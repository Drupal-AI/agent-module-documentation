# Configuration

Rankcrew has no settings form of its own. You configure it by turning on its REST
resources, creating a dedicated account for RankCrew to sign in with, and granting
that account the right permission. Take your time here — you are opening an
endpoint that can create published content on your site.

## 1. Enable the REST resources

The endpoints are inert until enabled. The easiest route is the **REST UI**
module:

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`).
2. Find the **RankCrew** resource (`rankcrew_rankcrew`) and enable it.
3. Allow the **POST** method.
4. Choose **JSON** as the format and **Basic Auth** (`basic_auth`) as the
   authentication provider — this matches what the RankCrew platform expects.
5. Save. Enable the companion vocabularies and categories resources too if
   RankCrew needs to read your taxonomy to map categories.

## 2. Create a dedicated API account

RankCrew connects by signing in as a normal Drupal user. Do **not** reuse a
person's admin account for this.

1. Go to **People → Add user** (`/admin/people/create`).
2. Create a user such as `rankcrew_bot` with a **strong, unique password**.
3. Give it a role that holds *only* the permission below — nothing more.

**Keep the password out of code and config.** In a DDEV project, store it as an
environment variable rather than typing it into any committed file:

```bash
ddev dotenv set .ddev/.env --rankcrew-api-password=<value>
ddev restart
```

Then set that value as the account's password (never commit `.ddev/.env`). Hand
the credential to RankCrew only over their secure connection.

## 3. Grant the REST permission

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **`restful post rankcrew_rankcrew`** to the role held by your API
   account — and to no one else.
3. Save.

## Notes before you go live

- **Bodies are stored as full HTML.** The module saves the incoming article body
  with the `full_html` text format. Grant `restful post rankcrew_rankcrew` **only**
  to the dedicated RankCrew account.
- **Content is published by default.** The payload's `is_published` flag defaults
  to *true*, so incoming articles go live unless RankCrew explicitly sends
  `is_published: false`. Decide whether you want an editorial review step.
- **Always use HTTPS.** Basic Auth sends the account password on every request;
  serve the endpoint over TLS so the credential is never exposed in transit.
- **Data leaves and enters your site.** RankCrew authors content on its own
  servers and pushes it in, and you share your content-type/taxonomy structure
  with the platform. Confirm this is acceptable for your site's content and
  privacy policy, and review RankCrew's documentation at
  <https://www.rankcrew.ai/documentation>.
