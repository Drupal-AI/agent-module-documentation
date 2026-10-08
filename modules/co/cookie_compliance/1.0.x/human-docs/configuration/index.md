# Configuration

The whole module is one small settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Cookie Compliance**, or navigate directly to
   `/admin/config/system/cookie-compliance-settings`.

## Fields

- **Enable cookie compliance banner** (`enabled`) — the master on/off switch. When
  ticked (and an App ID is set), the banner is injected site‑wide. Untick it to
  remove the banner without deleting your credentials.
- **App ID** (`app_id`) — your hu‑manity.co App ID, obtained by registering your
  domain at cookie‑compliance.co. It must match the pattern `^[a-z0-9-]+$`
  (lowercase letters, digits, and hyphens). This is an account identifier
  (configuration), not a secret.
- **App Secret Key** (`app_secret_key`) *(optional)* — your App Secret Key, subject
  to the same validation. It is stored but is not used in the page injection.

Save the form. When **Enable** is on and the **App ID** is non‑empty, every page
then carries:

```html
<script>var huOptions = {'appID':'YOUR-APP-ID','currentLanguage':'en'}</script>
<script src="https://cdn.hu-manity.co/hu-banner.min.js"></script>
```

## Notes

- All consent logic — categories, cookie blocking, consent records — lives in the
  remote hu‑manity.co service; nothing is stored locally.
- The banner script loads from `cdn.hu-manity.co` on every page. If you run a
  Content‑Security‑Policy, allow that origin as a script source.
- Because the App ID is plain configuration, you can export `cookie_compliance.settings`
  and use a different App ID per environment (staging vs production) via config
  overrides.
