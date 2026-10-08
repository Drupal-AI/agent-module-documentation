# JSON Form Widget — manual setup guide

**JSON Form Widget** (`json_form_widget`) builds a nested Drupal field-edit form
directly from a [JSON Schema](https://json-schema.org/) document, and stores
everything the editor types back into the field as a single JSON string. Instead of
creating dozens of individual Drupal fields to capture a structured record, you hand
the module a schema and it generates the whole form — nested objects, repeatable
arrays, dropdowns, dates, file/link fields and all. It was originally extracted from
DKAN, where it drives dataset/metadata entry forms.

The important thing to understand is that this module is a **framework, not a
ready-to-use widget on its own**. It supplies the machinery for turning schemas into
forms, but *something has to supply the schema*. That "something" is a field-widget
plugin. The bundled **`json_form_widget_basic`** submodule is the simplest one — you
paste a JSON Schema straight into the field's form-display settings — and DKAN's own
widget is the reference implementation that pulls schemas from its metastore.
Developers can write their own by subclassing `JsonFormWidgetBase`. Because of this,
the module has **no configuration page of its own** (there are no global settings,
no permissions, and no Drush commands).

It depends on core **File** plus the contrib **Select2** and **Select or Other**
modules (Composer pulls those in), and it defines one plugin type,
`json_form_option_source`, for feeding option lists into schema-driven dropdowns
dynamically — for example straight from a taxonomy vocabulary. It ships custom form
elements too, including `upload_or_link` (let an editor either upload a file or paste
a remote URL in one field) and flexible date/date-range inputs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Select2 and Select or Other) and enable the module plus the basic submodule.

## Where it lives in the admin menu

There is no dedicated settings page. You use JSON Form Widget by choosing it as the
**form widget** for a field, under **Structure → (your entity type) → Manage form
display**. The widget then renders its schema-driven form wherever that entity is
edited.

## How to use it

1. **Enable the basic submodule** (`json_form_widget_basic`) if you don't have a
   custom widget of your own — it is the easiest way to get started.
2. **Add a field** to your content type that can hold the JSON output. The basic
   widget supports `json`, `json_native`, `text_long`, and `string_long` field
   types.
3. Go to **Manage form display** for that content type and set the field's widget to
   the JSON Form Widget (the basic one lets you **paste your JSON Schema** right into
   the widget settings).
4. Optionally add a companion **`schema.ui`** document to control labels, field
   order (weights), placeholders, and which widget each property uses.
5. Editors now see a full form generated from your schema; on save, their input is
   flattened back into a schema-shaped structure and stored as JSON in the field.

**Dynamic dropdowns.** To populate a select list from live data rather than a fixed
enum, use the `json_form_option_source` plugin type — the bundled `taxonomy` source
fills options from a vocabulary, and you can write your own plugin (place the class
in `src/Plugin/JsonFormOptionSource/`) to pull options from an API or entity query.

**For developers.** To supply schemas from your own source rather than by pasting
them, subclass `JsonFormWidgetBase` and implement `resolveSchema()` /
`resolveUiSchema()`. See the sibling [`agent/`](../agent/start.md) docs for the
service and plugin details.
