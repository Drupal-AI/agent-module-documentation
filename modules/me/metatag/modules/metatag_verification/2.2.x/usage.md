Adds site-ownership verification meta tags for Google, Bing, Yandex, Baidu, Pinterest, Facebook, Norton, Pocket and more.

---

Search engines and web services ask you to prove you own a domain by placing a specific verification `<meta>` tag in the site's `<head>`. This submodule registers those verification tags as Metatag plugins so you can paste the provided tokens into global defaults and confirm ownership in each service's console. It covers Google, Bing (`msvalidate.01`), Yandex, Baidu, Facebook domain verification, Pinterest (`p:domain_verify`), Norton Safe Web, Pocket, SiwecosToken, and Zoom. Depends on the main Metatag module. Typically configured once, globally.

---

- Verify site ownership with Google Search Console (`google-site-verification`).
- Verify with Bing Webmaster Tools (`msvalidate.01`).
- Verify with Yandex Webmaster (`yandex-verification`).
- Verify with Baidu (`baidu-site-verification`).
- Verify a Facebook domain (`facebook-domain-verification`).
- Verify a Pinterest account (`p:domain_verify`).
- Verify with Norton Safe Web (`norton-safeweb-site-verification`).
- Verify with Pocket (`pocket-site-verification`).
- Provide the Siwecos security-scan token (`siwecostoken`).
- Verify a Zoom domain (`zoom-domain-verification`).
- Set all verification tags globally as defaults.
- Confirm ownership before submitting a sitemap.
- Enable search-console features that require verification.
- Keep verification tokens in exportable config.
- Re-verify quickly after a domain change.
- Manage multiple services' tokens from one screen.
- Avoid hard-coding verification tags in templates.
- Standardize verification across a multisite platform.
