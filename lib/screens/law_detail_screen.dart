import 'package:flutter/material.dart';
import '../models/law.dart';
import '../models/law_tree_item.dart';
import '../services/api_service.dart';
import '../widgets/discussion_card.dart';

class LawDetailScreen extends StatefulWidget {
  final String? initialLawId;
  final String? initialLawTitle;

  const LawDetailScreen({
    super.key,
    this.initialLawId,
    this.initialLawTitle,
  });

  @override
  State<LawDetailScreen> createState() => _LawDetailScreenState();
}

class _LawDetailScreenState extends State<LawDetailScreen> {
  final ApiService _api = ApiService();
  String? _selectedLawId;
  String? _selectedLawTitle;
  String? _selectedCategory; // Track selected category
  List<LawTreeItem> _lawCategories = [];
  List<LawTreeItem> _currentItems = []; // Current displayed items (categories or laws)
  bool _isLoadingTree = true;
  String? _errorMessage;

  // Controllers for discussion form and search
  final TextEditingController _discussionTitleController = TextEditingController();
  final TextEditingController _discussionContentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSubmittingDiscussion = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _selectedLawId = widget.initialLawId;
    _selectedLawTitle = widget.initialLawTitle;
    _loadLawTree();
  }

  @override
  void dispose() {
    _discussionTitleController.dispose();
    _discussionContentController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadLawTree() async {
    setState(() {
      _isLoadingTree = true;
      _errorMessage = null;
    });

    try {
      final tree = await _api.getLawTree();
      setState(() {
        _lawCategories = tree;
        _currentItems = tree; // Initially show categories
        _isLoadingTree = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '法令ツリーの取得に失敗しました: $e';
        _isLoadingTree = false;
      });
    }
  }

  Future<void> _loadLawTreeWithCategory(String category) async {
    setState(() {
      _isLoadingTree = true;
      _errorMessage = null;
    });

    try {
      final laws = await _api.getLawTree(category: category);
      setState(() {
        _currentItems = laws;
        _selectedCategory = category;
        _isLoadingTree = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'カテゴリの法令取得に失敗しました: $e';
        _isLoadingTree = false;
      });
    }
  }

  Future<void> _performSearch(String keyword) async {
    if (keyword.trim().isEmpty) {
      return;
    }

    setState(() {
      _isSearching = true;
      _errorMessage = null;
    });

    try {
      final result = await _api.searchLaws(keyword);
      // Convert search results to LawTreeItem format
      final List<dynamic> items = result['items'] ?? [];
      final Set<String> seenIds = {};
      final List<LawTreeItem> searchItems = [];

      for (var item in items) {
        final String? id = item['law_id'] ?? item['LawId'];
        if (id != null && !seenIds.contains(id)) {
          seenIds.add(id);
          searchItems.add(LawTreeItem(
            id: id,
            name: item['law_title'] ?? item['LawTitle'] ?? '',
            type: 'law',
          ));
        }
      }

      setState(() {
        _currentItems = searchItems;
        _selectedCategory = null; // Clear category when searching
        _isSearching = false;
      });

      if (searchItems.isEmpty) {
        setState(() {
          _errorMessage = '検索結果が見つかりませんでした';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '検索に失敗しました: $e';
        _isSearching = false;
      });
    }
  }

  void _navigateBack() {
    setState(() {
      if (_selectedCategory != null) {
        // If we're in a category, go back to categories
        _currentItems = _lawCategories;
        _selectedCategory = null;
      }
    });
  }

  Future<void> _submitDiscussion() async {
    if (_discussionTitleController.text.isEmpty || _selectedLawId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('議題名を入力してください')),
      );
      return;
    }

    setState(() {
      _isSubmittingDiscussion = true;
    });

    try {
      await _api.createDiscussion(
        title: _discussionTitleController.text,
        lawId: _selectedLawId!,
        lawTitle: _selectedLawTitle ?? '',
        userId: 1, // TODO: Use actual user ID from auth
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('議論を作成しました')),
        );
        _discussionTitleController.clear();
        _discussionContentController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('議論の作成に失敗しました: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmittingDiscussion = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E2129),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('条文階層'),
          ],
        ),
        titleTextStyle: const TextStyle(color: Color(0xFFACACAC), fontSize: 15),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFF2E2E2E),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFF1E1E1E),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side
              Expanded(
                flex: 1,
                child: _selectedLawId == null
                    ? _buildLawList()
                    : _buildLawDetail(_selectedLawId!, _selectedLawTitle ?? ''),
              ),
              const SizedBox(width: 24),
              // Right Side
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Color(0xFF2E2E2E), width: 1),
                    ),
                  ),
                  child: _selectedLawId == null
                      ? _buildSearchPlaceholder()
                      : _buildDiscussionForm(_selectedLawTitle ?? ''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLawList() {
    if (_isLoadingTree || _isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF3F3B96)),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFACACAC), size: 48),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Color(0xFFACACAC), fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadLawTree,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F3B96),
              ),
              child: const Text('再試行', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (_selectedCategory != null) ...[
              IconButton(
                onPressed: _navigateBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              _selectedCategory != null ? '$_selectedCategory の法令' : '条文階層',
              style: const TextStyle(color: Color(0xFFACACAC), fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: _currentItems.isEmpty
              ? const Center(
                  child: Text(
                    '結果が見つかりませんでした',
                    style: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
                  ),
                )
              : ListView.builder(
                  itemCount: _currentItems.length,
                  itemBuilder: (context, index) {
                    final item = _currentItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          if (item.isCategory) {
                            // Load laws in this category
                            _loadLawTreeWithCategory(item.name);
                          } else {
                            // Select this law to view details
                            setState(() {
                              _selectedLawId = item.id;
                              _selectedLawTitle = item.name;
                            });
                          }
                        },
                        child: DiscussionCard(
                          title: item.name,
                          timeAgo: '', // No time for categories/laws
                          tag: item.type == 'category' ? 'カテゴリ' : '法令',
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildLawDetail(String lawId, String lawTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedLawId = null;
                  _selectedLawTitle = null;
                });
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              '条文階層（詳細）',
              style: const TextStyle(color: Color(0xFFACACAC), fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: FutureBuilder<LawDetail>(
            future: _api.getLawDetail(lawId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Color(0xFFACACAC), size: 48),
                      const SizedBox(height: 16),
                      Text(
                        '法令詳細の取得に失敗しました: ${snapshot.error}',
                        style: const TextStyle(
                            color: Color(0xFFACACAC), fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    '法令データが見つかりませんでした',
                    style: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
                  ),
                );
              }

              final detail = snapshot.data!;
              return _buildDetailContent(detail);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailContent(LawDetail detail) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: const Color(0xFF1E2129),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF2E2E2E))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      detail.lawTitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                        color: const Color(0xFF252830),
                        borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(detail.category, style: const TextStyle(color: Color(0xFFACACAC), fontSize: 12)))
                  ],
                ),
                const SizedBox(height: 8),
                 Text(detail.lawNum, style: const TextStyle(color: Color(0xFFACACAC), fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: detail.articles.length,
              itemBuilder: (context, index) {
                final article = detail.articles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.articleText, // In design image, it seems article text is shown
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      // const Divider(color: Color(0xFF2E2E2E)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
  }

  Widget _buildSearchPlaceholder() {
    return Column(
      // mainAxisAlignment removed to use Spacers for custom positioning
      children: [
        const Spacer(flex: 1),
        const Text(
          '条文を選択して詳細を表示',
          style: TextStyle(
            color: Color(0xFFACACAC),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '左側のリストから条文を探索、または検索してください',
          style: TextStyle(
            color: Color(0xFFACACAC),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2129),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2E2E2E)),
          ),
          child: Column(
            children: [
              const Text(
                '法令検索',
                 style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  _performSearch(value);
                },
                decoration: InputDecoration(
                  hintText: 'キーワードを入力（例：道路交通法）',
                  hintStyle: const TextStyle(color: Color(0xFFACACAC)),
                  filled: true,
                  fillColor: const Color(0xFFEBEBEB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _performSearch(_searchController.text);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF3F3B96), // Purple color from image
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const Spacer(flex: 2), // Pushes content up to roughly 1/3 viewport height
      ],
    );
  }
  
  Widget _buildDiscussionForm(String lawTitle) {
    return Center( // Center the form vertically/horizontally
      child: Container(
        width: 400, // Fixed width card
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2129),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF2E2E2E)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                '議論を作成',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
             const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, color: Color(0xFFACACAC)),
                children: [
                  TextSpan(text: lawTitle, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  const TextSpan(text: 'について、議論を開始しましょう。'),
                ],
              )
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _discussionTitleController,
              decoration: InputDecoration(
                hintText: '議題名（例：この法律わかりにくい？）',
                hintStyle: const TextStyle(color: Color(0xFFACACAC)),
                filled: true,
                fillColor: const Color(0xFFEBEBEB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _discussionContentController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: '書き込み内容',
                hintStyle: const TextStyle(color: Color(0xFFACACAC)),
                filled: true,
                fillColor: const Color(0xFFEBEBEB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: _isSubmittingDiscussion ? null : _submitDiscussion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3B96),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: _isSubmittingDiscussion
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('書き込む', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
