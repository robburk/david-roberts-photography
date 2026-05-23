# David Roberts — Real Estate Photography

Minimalist portfolio website for David Roberts, a real estate, aerial, and property media photographer.

## Stack

Plain HTML + CSS + JavaScript, no build step. Static files served as-is.

## Structure

```
index.html          English version
pt.html             Portuguese version
assets/
  display/          Optimised web JPEGs
  photos/           Source photos
```

## Local preview

```bash
cd "Davids Real estate photography website"
python3 -m http.server 8001
# open http://localhost:8001
```

## Deploy

Connected to Cloudflare Pages. Every push to `main` auto-deploys.
