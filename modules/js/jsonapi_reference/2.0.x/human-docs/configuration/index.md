# Configuration

Setting up JSON:API Reference has two parts: telling the module about the remote
JSON:API source, and adding a Typed Resource Object field whose widget knows which
remote attribute to autocomplete against.

## Configure the JSON:API source

The module provides a configuration form
(`jsonapi_reference.json_api_reference_config_form`) where you set up the connection
to the remote system. This is where the remote endpoint and its access details live.

Keep the security notes in mind as you fill it in:

- The remote endpoint is **admin-configured** (not supplied by end users), so this
  is not an open SSRF surface — but only point it at endpoints you trust.
- Authentication to the remote system is assumed to be **HTTP basic
  authentication**. Store the credentials as **secrets** (for example via an
  environment variable / Key entity) rather than hard-coding or committing them.
- Make sure the endpoint is reached over **TLS** so credentials and data are not
  sent in the clear.
- All referenced fields are assumed to come from the **same remote system**.

## Add a Typed Resource Object field

1. Go to your content type's **Manage fields** (for example **Structure → Content
   types → *(type)* → Manage fields**) and add a new field of type **Typed Resource
   Object**.
2. Save the field and its settings.

## Configure the autocomplete widget

On the same content type's **Manage form display**, the Typed Resource Object field
uses an **autocomplete widget** that looks up resources in the remote system as you
type.

- Because different resource object types autocomplete by comparing your input
  against a **different attribute**, the widget settings let you choose **which
  attribute** autocompletion matches against. Set this to the remote field your
  editors will recognize (for example a title, name, or email).

## A note on display

The module provides **no field formatters**, so on **Manage display** the reference
currently shows as the **GUID** of the remote resource object, rendered as plain
text. If you need friendlier output, you would supply your own formatter. Remember
to treat the fetched remote data as **external input** and escape it on output.

## Evaluation shortcut

For a quick, non-production evaluation setup, the
[`test_jar`](https://www.drupal.org/project/test_jar) Drupal Recipe configures a
site with JSON:API Reference ready to test.
