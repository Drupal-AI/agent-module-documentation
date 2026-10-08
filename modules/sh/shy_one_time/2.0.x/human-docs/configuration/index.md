# Configuration

Shy One-Time needs **no configuration to do its main job** — the CrawlerDetect library
already recognises thousands of bots and crawlers and protects your reset links out of
the box. The settings form exists only for the case where a particular offender is not
in that library and you want to block it yourself.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/system/shy_one_time`** (route `shy_one_time.settings`).

## The custom User-Agent block list

The form has a single text field where you list additional User-Agents to block on the
`user.reset` route. The rules are simple:

- Enter **one User-Agent per line**.
- Paste the User-Agent string exactly as it appears, for example:

  ```
  Mozilla/5.0 (Windows; U; Windows NT 6.1; en-us; rv:1.9.2.3) Gecko/20100401 YFF35 Firefox/3.6.3
  ```

When a request to the reset route matches one of these, the visitor is redirected to
the login form with a 302 and the one-time link is **not** consumed.

To help you find the right string to add, the module logs requests to the reset route
in Drupal's database log (**Reports → Recent log messages**,
`/admin/reports/dblog`). If a legitimate login fails because a scanner got there first,
check the log to see which User-Agent was involved and add it here. An ongoing
community list of User-Agents worth blocking is maintained in the module's issue queue
(issue #3373364).

## Keep the list narrow — this is the important caveat

Matching is done purely by User-Agent string, which anyone can spoof, so this offers no
guarantee about who actually fetched a link. More importantly, **if a real person's
browser matches a pattern you add here, they will be redirected to the login page and
can never complete their password reset.** Add specific, distinctive scanner
User-Agents only; never add broad patterns that could catch ordinary browsers.
