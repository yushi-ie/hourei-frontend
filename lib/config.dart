class Config {
  // Production API URL (empty string for Vercel - uses rewrites proxy)
  // For web deployment on Vercel, use empty string to leverage vercel.json rewrites
  static const String baseUrl = "";
  
  // For local development, uncomment one of the following:
  // Direct API access (for local Flutter development):
  // static const String baseUrl = "http://52.196.249.110:8000";
  // Android Emulator uses 10.0.2.2 to access host localhost
  // static const String baseUrl = "http://10.0.2.2:8000"; 
  // iOS Simulator uses localhost
  // static const String baseUrl = "http://localhost:8000";
}
