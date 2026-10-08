Uploads an Apple Pay domain-verification file and serves it at the exact well-known path Apple requires to confirm you own the domain.

---

Apple Pay (and payment providers that ride on it, such as Stripe's payment element) verify that you control a domain by fetching a small association file at `/.well-known/apple-developer-merchantid-domain-association`. This module gives site admins a single settings form to upload that file (stored as a private managed file), then serves its raw contents — as `text/plain` — at both the extensionless and `.txt` well-known routes so Apple's crawler can read it. There is no gateway logic, no API calls, and no other moving parts: it is a thin, focused bridge between Drupal's private file storage and the fixed URL Apple looks for. The serving routes are publicly readable (Apple fetches anonymously); only users with the module's admin permission can change which file is served.

---

- Complete Apple Pay merchant domain verification for a Drupal site without hand-editing the docroot or web server config.
- Host the `apple-developer-merchantid-domain-association` file that Apple's Developer portal issues for a registered merchant domain.
- Satisfy Stripe's "payment method domain" registration for the Stripe payment element / Apple Pay button.
- Serve the association file from Drupal itself so it survives redeploys and container rebuilds (no file left behind in `/web/.well-known`).
- Update the verification file through the admin UI when Apple re-issues it, without a code deploy.
- Keep the raw association file in Drupal's private filesystem instead of a world-readable static file.
- Provide the file at both `/.well-known/apple-developer-merchantid-domain-association` and the `.txt` variant, covering tooling that appends the extension.
- Enable Apple Pay on the web for a Drupal Commerce storefront that uses a compatible payment gateway.
- Verify multiple environments (dev/stage/prod) by uploading the environment-appropriate file per site.
- Delegate verification-file management to a trusted admin role via a dedicated, restricted permission.
- Re-run verification after moving to a new domain or subdomain by swapping the uploaded file.
- Confirm ownership for Apple Pay on the Web JavaScript SDK integrations.
- Replace a manual web-server rewrite rule that previously exposed the association file.
- Give agencies a repeatable, config-driven way to onboard Apple Pay for client sites.
- Serve the file with the correct `text/plain` content type that Apple's verification expects.
- Troubleshoot "domain not verified" errors by confirming the exact bytes Drupal serves at the well-known path.
- Pair with Commerce Stripe so the Apple Pay option appears on the Stripe payment element.
- Clear caches and immediately re-check the served file when Apple reports a mismatch.
- Keep verification purely as site configuration (the file reference lives in `apple_pay_verification.settings`).
- Support Drupal 9, 10, and 11 sites with one small module rather than a bespoke controller.
