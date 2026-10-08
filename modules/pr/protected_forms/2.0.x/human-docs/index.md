# Protected Forms — manual setup guide

**Protected Forms** (`protected_forms`) is a lightweight, non-invasive spam filter for
Drupal forms. It blocks submissions that contain undesired language scripts or known
spam patterns — without adding a CAPTCHA, a puzzle, or any extra step for legitimate
users. If your comment, contact, webform, user-registration, or private-message forms
are collecting spam, this module quietly rejects the bad ones while genuine visitors
never notice it is there.

It protects the usual spam magnets automatically: any non-admin form whose id relates
to users, nodes, comments, contact messages, or webforms (plus the private-message add
form). For each protected submission it does two checks. First, a **language-script
check**: it samples characters from the submitted text and rejects the submission if
they belong to a Unicode script you have not allowed — a simple, effective way to block
Cyrillic or CJK spam on a Latin-only site. Second, a **pattern check**: it scans the
text for a configurable blocklist of spammy words and URL fragments (like `http://`,
`www`, or specific spam keywords) and rejects on a match.

You control all of this from a single settings page: which scripts are allowed, how
many characters to sample, the blocklist of reject patterns, an allow-list to
whitelist legitimate strings, a list of forms to exclude entirely, and the message
shown to blocked submitters. Rejections can be logged and are counted on the site's
Status report, so you can tune the rules over time. Two permissions round it out — one
to configure the module, and one to let trusted roles bypass all checks.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including every settings key and the exact validation flow — read
the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings page field by field,
   the permissions, and how to tune the filter.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Content authoring → Protected Forms**
(`/admin/config/content/protected_forms`), gated by the **Administer protected forms**
permission. The running count of rejected submissions appears on the **Reports →
Status report** page.
