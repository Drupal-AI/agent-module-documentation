# Effect AOS Field — manual setup guide

**Effect AOS Field** (`effect_aos_field`) adds a field type that lets a **content
editor** apply [AOS](https://michalsnik.github.io/aos/) (Animate On Scroll) effects
to *other* fields on the same content item — a fade, flip, slide, or zoom that plays
as the reader scrolls the field into view — chosen directly from the entity's edit
form, per item.

What makes it distinctive is *where* the choice lives. Other AOS modules configure
animations at the content-type or paragraph-type level, so every item of that
bundle animates the same way. Effect AOS Field instead stores the configuration
**per entity**, so two nodes of the same type can have completely different effects,
or none at all — the decision belongs to the author filling in the content, not the
site builder.

The site builder's job is to add the field once and decide which sibling fields
editors are allowed to animate; the editor then picks an effect, duration, easing,
delay, and anchor placement for each allowed field from an interactive widget. The
animation attributes are written into the markup server-side during preprocessing,
so AOS registers the trigger points on first page load (no "scroll twice to see it"
problem). The available effects, easing functions, and anchor placements are defined
in YAML and discoverable, so a module or theme can extend or override the option
lists without patching this module. It requires no other Drupal modules and supports
Drupal 10 and 11.

One thing to note for privacy-sensitive or offline builds: by default the module
loads the AOS JavaScript/CSS **library from a public CDN** (and without a
subresource-integrity hash). If you would rather self-host it, override the library
definition in your theme or a custom module to point at a local copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no global settings page** for this module — everything is configured per
field instance (on Manage form display) and per content item (on the edit form), as
described in "How to use it" below.

## Where it lives in the admin menu

Effect AOS Field adds no central settings page. You add its field at **Structure →
Content types (or Paragraph types) → (bundle) → Manage fields**, choose which
sibling fields may be animated at that bundle's **Manage form display**, and pick
the actual effects while editing content.

## How to use it

1. Go to the **Manage fields** page of the content type or paragraph type you want
   to enhance and add a field of type **AOS Animation Effects**.
2. Go to **Manage form display** for that bundle, open the new field's widget
   settings, and select which of the bundle's other fields are allowed to receive
   animations.
3. Edit any content of that type. You will see an **Animation Effects
   Configuration** fieldset: pick a target field, an effect, and its parameters
   (duration, easing, delay, anchor placement), then click **Add Effect**. Add,
   edit, or remove as many entries as you like before saving.

### Extending the option lists (for developers/themers)

The effect, easing, and anchor-placement options are aggregated from any module or
theme `*.options.yml` file. Add such a file in your theme or module to extend or
override the choices without changing this module.
