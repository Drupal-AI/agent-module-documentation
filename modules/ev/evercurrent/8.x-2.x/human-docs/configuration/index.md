# Configuration

Evercurrent's configuration is small: it needs the **API key** that ties your site to
your Evercurrent account, and it lets you set the **endpoint** the reports are sent to.
The care here is mostly about treating that key as a secret and making sure only your
production site reports.

## Get your API key

1. Log in or create an account at
   [Evercurrent](https://www.drupal.org/project/evercurrent).
2. Create a new **site** in Evercurrent. You will be given an **API key** for it.

## Store the API key securely

The API key is a credential — do not commit it to version control. Rather than saving it
in the settings form (where it becomes part of exported configuration), Evercurrent lets
you supply the key from `settings.php`. The module reads it with
`Settings::get('evercurrent_environment_token')`, so add this on the **production** site
only:

```php
$settings['evercurrent_environment_token'] = 'your-api-key';
```

Leave the settings-form **API key** field empty on all environments and the production
`settings.php` value is used automatically. (If you check *Override API key stored in
settings.php* on the form, the form's key value takes precedence instead.)

If you keep secrets in environment variables, you can still source the value there —
assign it to the setting Evercurrent actually reads, e.g.
`$settings['evercurrent_environment_token'] = getenv('EVERCURRENT_API_KEY');` — but the
module itself only ever looks at `evercurrent_environment_token`, not at any environment
variable directly.

## Enter the settings

On the module's settings form:

- **API key** — paste (or reference from the environment) the key from your Evercurrent
  site. This authenticates your site's reports.
- **Endpoint** — the Evercurrent server URL that reports are sent to. Leave it at your
  trusted Evercurrent endpoint and ensure it is **HTTPS** — the report contains
  version-fingerprinting data about your site, so it should only travel encrypted to a
  host you trust.

Save the form.

## Keep non-production environments quiet

Evercurrent expects **one API key per environment**. If you copy your site to
development or staging, you do not want those copies reporting updates under the
production key. The recommended approach (per the module's README) is to set the API
key in **`settings.php` on the production site only** (`$settings['evercurrent_environment_token']`),
so development environments have no key and therefore do not report.

## Verify

Once the key is saved, your site will report its needed updates to Evercurrent. Confirm
the site appears on your Evercurrent dashboard and that update notifications begin to
arrive.
