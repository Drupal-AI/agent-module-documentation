Spambot protects the user registration form (and optionally Webform submissions) against known spammers by checking the submitted email, username, and IP address against the Stop Forum Spam (www.stopforumspam.com) online blacklist.

---

Spambot alters the `user_register_form` (via `hook_form_FORM_ID_alter`) and adds a validation callback that queries the Stop Forum Spam (SFS) API with the registrant's email, username, and/or client IP. Each check has a configurable threshold (`spambot_criteria_email` default 1, `spambot_criteria_username` default 0/off, `spambot_criteria_ip` default 20): if SFS reports the value as a spammer at least that many times the registration is blocked with a configurable message, optionally logged, and optionally delayed (`sleep()`) to slow repeat attempts. Whitelists for email/username/IP exempt trusted values. Beyond registration, a cron job (`spambot_cron`, gated by `spambot_cron_user_limit`) scans existing accounts by ascending uid and can log, block, or delete matches; a per-user **Spam** tab (`/user/{user}/spambot`) lets an admin check an account, report its nodes/comments to SFS, and unpublish/delete its content. Reporting spammers back to SFS requires an API key (`spambot_sfs_api_key`) registered at stopforumspam.com. Responses are cached in a dedicated `spambot` cache bin with separate expiry for hits vs. misses. IP addresses for a user are gathered from the `sessions` table, from comment hostnames, and from a module-owned `node_spambot` table populated on node insert. A bundled `spambot_validation` Webform handler plugin applies the same email/username/IP checks to any webform. Users/roles with the `protected from spambot scans` permission bypass all checks. The module talks only to the fixed stopforumspam.com host; there is no local block/allow decision beyond the thresholds and whitelists.

---

- Block user registrations whose email address is a known Stop Forum Spam spammer.
- Block registrations from IP addresses reported to SFS more than a chosen number of times.
- Optionally block on username matches (off by default to avoid false positives on shared handles).
- Whitelist trusted email addresses, usernames, or IPs so they are never checked or blocked.
- Show a custom "blacklisted" message to blocked registrants, tuned per reason (email/username/IP).
- Deliberately delay (`sleep`) a blacklisted registration attempt to slow down repeat spambots.
- Log every blocked registration to the Drupal log for auditing.
- Scan existing user accounts during cron and automatically block or delete detected spammers.
- Scan only a limited number of accounts per cron run to avoid exceeding the SFS daily query limit.
- Skip already-blocked accounts during cron scans (or include them via a setting).
- Review a single account on its **Spam** tab and check it live against SFS before acting.
- Report a spam account's nodes and comments back to Stop Forum Spam (requires an API key).
- Unpublish or delete all nodes and comments authored by a spammer in a batch operation.
- Block or delete a spam user account directly from the Spam tab.
- Protect arbitrary Webforms from spam by attaching the `spambot_validation` handler and mapping email/username fields.
- Grant trusted roles the `protected from spambot scans` permission to bypass all spambot checks.
- Cache SFS responses to reduce API traffic, with a separate cache lifetime for non-spammer results.
- Toggle HTTPS vs HTTP for SFS API calls when a server lacks SNI support.
- Track author IP addresses of new nodes via the `node_spambot` table for later reporting.
- Reduce forum/comment spam on sites that require registration before posting.
- Enforce anti-spam registration checks without adding a CAPTCHA challenge for legitimate users.
- Resume a cron account scan from a specific uid, or restart the whole scan by resetting to 0.
- Fire the `spambot_registration_blocked` hook so other modules can react to a blocked attempt.
