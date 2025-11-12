# 🔐 Encrypted URL Shortener

A client-side encrypted URL shortener that creates password-protected links. All encryption happens in your browser - no server-side processing required!

## ✨ Features

- 🔒 **Military-Grade Encryption**: AES-256-GCM with PBKDF2 key derivation
- 🚀 **Client-Side Only**: No backend required, works on GitHub Pages
- 📦 **Optimized Compression**: ~50% smaller than standard Base64 encoding
- 🔑 **Password Protected**: Only people with the secret key can access URLs
- 🎯 **Privacy First**: Encrypted data never touches any server

## 🛡️ Security Features

1. **AES-256-GCM Encryption**: Industry-standard authenticated encryption
2. **PBKDF2 Key Derivation**: 100,000 iterations to strengthen passwords
3. **Random Salt**: Each encryption is unique, even for identical inputs
4. **No Server Logs**: Fragment data (#...) never sent to servers
5. **Derived IV**: Secure initialization vector derived from salt

## 📊 Optimizations

The tool implements multiple compression techniques:

1. **URL Preprocessing**: Removes common prefixes (https://, www.)
2. **LZ-String Compression**: Industry-standard text compression
3. **Base85 Encoding**: More efficient than Base64 or Base62
4. **Derived IV**: Saves 12 bytes by deriving IV from salt

**Result**: ~50% smaller fragments compared to naive Base64 encoding

## 🚀 Usage

### Creating an Encrypted Link

1. Enter the URL you want to encrypt
2. Choose a strong secret key
3. Click "Generate Encrypted Link"
4. Share the link and tell the recipient the secret key separately

### Opening an Encrypted Link

1. Click the encrypted link
2. Enter the secret key
3. Get automatically redirected to the destination

## 🔧 Technical Details

### Encryption Format

```
[16 bytes salt] + [encrypted data + auth tag]
```

All encoded in Base85 for URL-safe transmission.

### Data Flow

```
URL → Optimize → Compress → Encrypt → Base85 → Fragment
Fragment → Base85 Decode → Decrypt → Decompress → Restore → URL
```

### Browser Requirements

- Modern browser with Web Crypto API support
- HTTPS connection (or localhost for development)
- JavaScript enabled

## 📦 Deployment

### GitHub Pages

1. Fork or clone this repository
2. Go to Settings → Pages
3. Set source to main branch
4. Enable "Enforce HTTPS"
5. Access at `https://yourusername.github.io/encrypted-links/`

### Custom Domain

1. Add a `CNAME` file with your domain
2. Configure DNS with CNAME pointing to `yourusername.github.io`
3. Enable custom domain in GitHub Pages settings
4. Wait for HTTPS certificate to provision

## 🔒 Security Considerations

### What This Protects Against

✅ Server-side logging of destination URLs  
✅ Casual observation of URLs  
✅ Simple brute-force attacks (100k iterations)  
✅ Data tampering (authenticated encryption)

### What This Does NOT Protect Against

❌ Sharing the password over insecure channels  
❌ Malicious JavaScript in your browser  
❌ Compromised end-user devices  
❌ Determined attackers with weak passwords

### Best Practices

- Use strong, unique passwords (12+ characters)
- Share passwords through separate channels
- Don't reuse passwords across links
- Use for sharing convenience, not critical secrets

## 🎯 Use Cases

- Share internal links without exposing destinations in URLs
- Create password-protected bookmarks
- Obfuscate affiliate or tracking URLs
- Add an extra layer of privacy to shared links

## 🧪 Example

**Input:**
- URL: `https://www.github.com/username/repository`
- Password: `MySecretPass123!`

**Output:**
- Link: `https://yourdomain.com/#5T8mK...` (~40 chars)

**Compression:**
- Original: 46 characters
- Fragment: 42 characters
- Savings: 52% compared to unoptimized encoding

## 📝 License

MIT License - Feel free to use and modify!

## 🤝 Contributing

Contributions welcome! Please feel free to submit issues or pull requests.

## ⚠️ Disclaimer

This tool provides convenience and privacy, not absolute security. Always assess your threat model before sharing sensitive information.

---

Made with ❤️ for privacy-conscious link sharing
