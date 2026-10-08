# Configuration

The only thing Smartsheet needs to work is a valid **access token**. There are two
ways to provide it.

## 1. Generate a Smartsheet access token

Log in to the Smartsheet web app (`https://app.smartsheet.com/b/home`) and generate
a personal API access token from your account settings. Copy it somewhere safe — you
will only see it once.

## 2. Give the token to Drupal

The module reads the token from the `access_token` key in the `smartsheet.config`
configuration namespace. You can set it either through the admin UI or in
`settings.php`.

### Option A — the administration UI

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → Web services → Smartsheet API**
   (`/admin/config/services/smartsheet`).
3. Paste your access token into the field and save.

### Option B — in `settings.php` (recommended for secrets)

Keeping the token out of the database and out of exported configuration is safer.
In `settings.php`, read it from an environment variable rather than hard-coding it:

```php
$config['smartsheet.config']['access_token'] = getenv('SMARTSHEET_ACCESS_TOKEN');
```

Set `SMARTSHEET_ACCESS_TOKEN` in your server or DDEV environment (never commit the
value). A config override set this way takes precedence over whatever is stored via
the admin form.

## Using the client in code

Once the token is set, the `smartsheet.client` service is ready to use. It exposes
four methods that map to the REST verbs:

```php
$client = \Drupal::service('smartsheet.client');
$client->get($path, $options);          // GET
$client->post($path, $data, $options);  // POST
$client->put($path, $data, $options);   // PUT
$client->delete($path, $options);       // DELETE
```

`$data` is the request body for POST/PUT, and `$options` is passed straight through
to the underlying Guzzle request (use it to add query-string parameters, for
example). See the [Smartsheet REST API docs](https://smartsheet.github.io/api-docs/)
for the available endpoints.

## Sending form submissions to a sheet

To have a Form API form append its submission to a Smartsheet sheet as a new row,
add these two properties to the form array:

- `$form['#smartsheet_sheet_id']` — the ID of the target sheet.
- `$form['#smartsheet_column_mapping']` — an associative array whose keys are form
  field names and whose values are the matching sheet column titles or column IDs.

For example:

```php
$form['#smartsheet_sheet_id'] = 1234567890;
$form['#smartsheet_column_mapping'] = [
  'firstname' => 'First Name',
  'lastname'  => 'Last Name',
  'email'     => 4074863598216325,
];
```

Each mapped, submitted value is then inserted into the corresponding column of a new
row.
