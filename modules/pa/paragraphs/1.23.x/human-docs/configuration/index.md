# Configuration

Paragraphs has very little "settings form" configuration — the real work is
**building Paragraph types and wiring up a Paragraphs field**. This page walks
through both, then covers the small global settings form.

## Step 1 — Create a Paragraph type

1. Go to **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`) and
   click **Add paragraph type**.
2. Give it a human label (e.g. *Text*, *Image*, *Call to action*) and save.
3. On the new type, open **Manage fields** and add the fields this component needs —
   just as you would on a content type. A *Text* paragraph might have one
   formatted-text field; an *Image* paragraph an image field plus an optional
   caption.
4. Use **Manage form display** and **Manage display** to control how the fields are
   edited and rendered. Each Paragraph type can have its own view display and Twig
   template for precise theming.
5. Optionally, on the type's edit form, enable **behavior plugins** — these add
   extra options (layout, spacing, CSS classes) that render around the paragraph
   without adding storage fields.

Repeat for each component type you want editors to be able to place.

## Step 2 — Add a Paragraphs field to a host entity

1. On the content type (or any fieldable entity) that should hold the components,
   open **Manage fields → Add field** and choose the **Paragraph** field type.
2. Set the number of values — usually **Unlimited** so editors can stack as many
   components as they like.
3. In the field settings, choose **which Paragraph types are allowed** in this
   field, and optionally set a **default type** that is pre-added when the form
   opens.

## Step 3 — Configure the editing widget

On the host bundle's **Manage form display**, set the Paragraphs field's widget:

- **Paragraphs (Stable)** — the modern widget with duplicate, drag-and-drop, and
  collapsible summary modes. Recommended for new sites.
- **Paragraphs (Classic/Legacy)** — a simpler, stable widget kept for
  backward compatibility.

Widget settings let you choose the default **edit mode** (open, closed, or preview)
and the **add-item UX** (a dropdown, individual buttons, or a modal dialog).

## Global settings form

A single site-wide option lives at **Configuration → Content authoring →
Paragraphs settings** (`/admin/config/content/paragraphs`). It requires the
**Administer paragraphs settings** permission.

- **Show unpublished paragraphs** — when enabled, users who also hold the *view
  unpublished paragraphs* permission can see unpublished paragraph items. Leave it
  off to hide unpublished paragraphs from everyone.

Click **Save configuration** to apply.

## A note on translation

Paragraph *fields* are translatable, but the Paragraphs reference field on the host
entity must stay **non-translatable**. On a multilingual site, enable content
translation on the host bundle and mark individual Paragraph-type fields
translatable, but leave the Paragraphs field itself untranslated — Paragraphs will
warn you on the field config form if this is set up incorrectly.
