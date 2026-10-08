# Configuration

The base module has one settings form — for your Flickr API credentials — and each
placement submodule is then configured where it is used (the block in Block Layout,
the field on a content type, the filter in a text format).

## Step 1 — store your Flickr API key as a Key

Flickr Integration Suite depends on the **Key** module and expects your Flickr API
credentials to be held as a **Key entity**, so the value stays out of configuration
exports. On a DDEV site:

1. Save the value into DDEV's dotenv file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --flickr-api-key=YOUR_FLICKR_KEY
   ddev restart
   ```

   The flag `--flickr-api-key` becomes the environment variable `FLICKR_API_KEY`
   inside the web container.

2. Confirm the variable is present **without printing its value**:

   ```bash
   ddev exec 'test -n "$FLICKR_API_KEY"'   # exit status 0 means it is set
   ```

3. Create a Key entity backed by that environment variable (the Key module is
   already installed as a dependency):

   ```bash
   ddev drush key:save flickr_api_key --label='Flickr API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"FLICKR_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

## Step 2 — connect the key on the settings form

1. Go to **Configuration → System → Flickr Integration Suite**
   (`flickr_integration_suite.settings_form`).
2. Select the **Key** you created for the Flickr API credentials.
3. Save the form.

The Flickr API connection is now available to every placement submodule via the
suite's Drupal service.

## Step 3 — configure a placement

Depending on which submodule(s) you enabled:

- **Block** (`flickr_integration_suite_block`) — go to **Structure → Block
  layout**, place the Flickr block in a region, and configure the photoset/gallery
  it should show.
- **Field** (`flickr_integration_suite_field`) — add the Flickr field to a content
  type under **Manage fields**, then configure its display under **Manage
  display**.
- **Filter** (`flickr_integration_suite_filter`) — go to **Configuration → Content
  authoring → Text formats and editors**, edit a text format, and enable the
  Flickr filter (and, if you enabled it, the Colorbox variant) so editors can embed
  photosets inline.

## Operational cautions

- **Mind the rate limit.** A Flickr API key is rate-limited. A page that renders
  many photosets should be **cached** rather than fetching from Flickr on every
  request.
- **Check licensing.** Photo licensing on Flickr varies per image. Displaying a
  photostream is a rights decision you must make — the module cannot judge it for
  you.
