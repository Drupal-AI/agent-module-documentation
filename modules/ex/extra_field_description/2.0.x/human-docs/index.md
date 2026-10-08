# Extra Field Description — manual setup guide

**Extra Field Description** (`extra_field_description`) lets you add a **second description
that renders above a field's input widget** on entity edit forms. Core Drupal only gives you
one description, and it always sits *below* the field; this module adds an "extra description"
that appears *above* the widget — handy for instructions people should read before they start
filling a field in, like "Upload a square image" or "Do not include PII".

The extra description is configured per field on the **Manage form display** tab, inside the
field widget's settings (the cog). It's stored with the form-display configuration, so it
travels with a normal config export and can differ per form mode — you can show one note on
the default form and a different one (or none) on a custom form mode for the same field. A
small CSS library styles the note consistently, and there is special-case placement so it also
works cleanly on datetime/datelist widgets and entity-reference autocompletes.

Who can author these notes is gated by a dedicated permission, **Administer extra description**
(`administer field prefix`). One caveat to be aware of: the text you enter is emitted as **raw
markup** — it is *not* run through a text-format filter — so treat it as trusted,
admin-authored HTML. The settings form labels which HTML tags are "allowed" but does not
enforce that list.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no global settings page. You add an extra description per field, on the form display:

1. Go to the entity's **Manage form display** — for a content type that's
   `/admin/structure/types/manage/<bundle>/form-display` (other entity types and form modes
   have equivalent paths).
2. Click the **cog/gear** to open a field's widget settings.
3. Find **Extra description settings → Extra description** and type your note into the
   textarea. This element only appears if:
   - you hold the **Administer extra description** permission, and
   - the field is a **configurable field** (it does not appear for base fields).
4. Click **Update**, then **Save** the form display.

The note now renders as a prefix **above** that field's widget on the entity add/edit form,
wrapped in a `<div class="extra-description">` that the module's CSS styles (muted, slightly
smaller text). Placement is handled sensibly per widget type — for datetime/datelist and
entity-reference (autocomplete) fields the prefix is attached to the right element so it sits
above the whole control.

Because the value lives in the form-display configuration, you can give the same field
different guidance in different form modes, and the text ships with your configuration when you
export it.

### Good to know

- **Permission:** grant **Administer extra description** only to trusted editors. Reaching the
  widget-settings form in the first place already requires the restricted core "administer
  form display" permission, so this is a second, narrower gate on *authoring* the notes.
- **Raw HTML:** the stored text is output without filtering. Only people you trust should be
  able to author it — the "allowed tags" hint on the form is informational, not enforced.
