CleanTalk is a cloud anti-spam service that filters spam comments, registrations, and form submissions without showing a CAPTCHA. It sends submission metadata to the CleanTalk API for a spam verdict and can block bots at the request level with its SpamFireWall.

---

The module integrates a Drupal site with the CleanTalk cloud service. Every enabled form (comments, user registration, contact forms, webforms, forum topics, search, node content, and custom/external forms) is checked by sending the submitted data to the CleanTalk API, which returns an allow/deny verdict — so spammers are stopped invisibly, without a CAPTCHA or challenge. It also ships a SpamFireWall (SFW) that blocks known spam IP addresses and bots before the page even renders, an optional Anti-Crawler and Anti-Flood layer, and a JavaScript bot detector. Everything is driven from one settings form and stored in the single `cleantalk.settings` config object; the only required value is the CleanTalk **Access key** (`cleantalk_authkey`), obtained from a cleantalk.org account. Per-form toggles let you choose exactly which forms are protected, and URL/field/role exclusions let you skip trusted paths, fields, or user roles. Note that live spam verdicts require a valid Access key and outbound network access to the CleanTalk API; without them the form-check config is still stored but no remote checks occur. Extra admin screens let you retroactively scan existing users and comments for spam.

---

- Block spam comments on articles and other content without a CAPTCHA
- Stop fake/bot user registrations at signup
- Protect Webform submissions from spam
- Protect core Contact form (site-wide and personal) submissions
- Filter spam on Forum topic posts
- Keep the search form from being abused by bots
- Check spam on newly added node content
- Protect arbitrary custom forms (CCF — custom contact forms) built by other modules
- Protect external/third-party forms whose action posts off-site
- Block known spam bots and IPs at the request level with SpamFireWall (SFW)
- Add an Anti-Crawler layer to stop aggressive crawlers
- Add an Anti-Flood layer to rate-limit rapid repeated requests from one IP
- Use the JavaScript bot detector to catch automated browsers
- Exclude specific URLs/paths from spam checking (plain match or regexp)
- Exclude specific form fields from being sent to the API (plain match or regexp)
- Exempt trusted user roles from spam checks
- Retroactively scan and delete existing spam user accounts from an admin screen
- Retroactively find and remove existing spam comments
- Add a `noindex` meta tag to search-result pages to keep them out of search engines
- Enable comment automoderation with a minimum-approved-comments threshold per user
- Set anti-spam cookies (or an alternative cookie mechanism) to improve bot detection
- Route API calls through Drupal's HTTP client instead of raw cURL when needed
- Turn on debug logging to troubleshoot why a submission was allowed or blocked
- Centralize all anti-spam form protection through one cloud service instead of many modules
- Run a CAPTCHA-free spam defense that does not annoy legitimate visitors
- Restrict who can change anti-spam settings via a dedicated permission
