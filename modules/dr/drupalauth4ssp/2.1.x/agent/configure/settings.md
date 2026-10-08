# Configure DrupalAuth for SimpleSAMLphp

Settings form `Drupal\drupalauth4ssp\Form\SettingsForm` (`ConfigFormBase`, form id
`drupalauth4ssp_settings`) at route `drupalauth4ssp.settings` →
`/admin/config/people/drupalauth4ssp` (perm `administer drupalauth4ssp configuration`). It
edits the single config object **`drupalauth4ssp.settings`**.

## Config keys

| Key | Type (schema) | Form element | Meaning |
|---|---|---|---|
| `returnto_list` | `sequence` of `string` | textarea, one entry per line, **required** | Allowlist of URL patterns that a service provider's `ReturnTo` (and logout `ReturnTo`) value may match. Uses core `path.matcher` wildcard syntax: `*` is a wildcard, one pattern per line. Examples from the form: `www.example.com/specific-path`, `www.example.com*` (whole domain), `*example.com*` (all subdomain paths). |
| `idp_logout_returnto` | `uri` | textfield | URL the user is sent to after an **IdP-initiated** logout completes in SimpleSAMLphp. Leave empty to return to the site home page (`base_path()`). |

Install default (`config/install/drupalauth4ssp.settings.yml`):

```yaml
returnto_list:
  - '*'
idp_logout_returnto: ''
```

`returnto_list` is the allowlist of service-provider `ReturnTo` URL patterns the IdP returns users
to after login/logout (core `path.matcher` wildcard syntax, one pattern per line). Populate it with
your SPs' URL patterns; the install profile seeds a single placeholder `'*'` entry to replace.

## Form processing

- `submitForm()` splits the `returnto_list` textarea on `PHP_EOL`, `trim()`s each line, and
  stores the resulting array; it saves `idp_logout_returnto` as entered.
- `validateForm()` validates only `idp_logout_returnto`, by calling SimpleSAMLphp's
  `SimpleSAML\Utils\HTTP::checkURLAllowed()`; any thrown exception becomes a form error on that
  field. (`returnto_list` entries are stored as-is.)

## Runtime consumer

`SspHandler::returnPathIsAllowed($path)` (service `drupalauth4ssp.ssp_handler`) is the single
gate that consults `returnto_list`:

```php
$returnto_list = $this->config->get('returnto_list');
return $this->pathMatcher->matchPath($path, implode(PHP_EOL, $returnto_list));
```

## Set it with Drush / PHP

```bash
# returnto_list is a sequence — set each element by index.
ddev drush config:set drupalauth4ssp.settings returnto_list.0 'https://sp1.example.com*' -y
ddev drush config:set drupalauth4ssp.settings returnto_list.1 'https://sp2.example.com*' -y
ddev drush config:set drupalauth4ssp.settings idp_logout_returnto 'https://www.example.com/' -y
```

```php
\Drupal::configFactory()->getEditable('drupalauth4ssp.settings')
  ->set('returnto_list', ['https://sp1.example.com*', 'https://sp2.example.com*'])
  ->set('idp_logout_returnto', 'https://www.example.com/')
  ->save();
```

## Notes / history

- `config/schema/drupalauth4ssp.schema.yml` defines the config object as
  `drupalauth4ssp.settings` with the two keys above.
- Older branches also stored `authsource` and `cookie_name`. In 2.1.x those are removed:
  `drupalauth4ssp.post_update.php` (`drop_authsource_param`) clears `authsource`, and
  `convert_returnto_list_param` migrated the old newline-string `returnto_list` into a sequence.
  The SimpleSAMLphp authsource name now lives only in SimpleSAMLphp's `authsources.php`, not in
  Drupal config.
