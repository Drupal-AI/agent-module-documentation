# Configuration

Custom Elements has two configuration surfaces: a small **settings form** provided by
the base module, and the richer **per‑view‑mode output mapping** provided by the
optional Custom Elements UI submodule.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Custom Elements**, or navigate directly to
   `/admin/config/system/custom-elements`.

This form holds the module's general settings for how Drupal serializes content into
custom‑element markup or its JSON representation. Adjust the options as your decoupled
setup requires, then **Save configuration**.

## Configuring output per entity view mode

The main day‑to‑day configuration — deciding *which* fields become *which* elements
and attributes for each entity type and view mode — is provided by the **Custom
Elements UI** submodule (`custom_elements_ui`, 3.x only). Enable it (see
[Installation](../installation/index.md#submodules--enable-only-what-you-need)),
then configure the custom‑element output on an entity type's view‑mode display, the
same way you would manage a normal display. Use a dedicated view mode for the
custom‑element output so it stays separate from your themed HTML displays.

## Settle the markup contract first

The single most important configuration decision isn't in any form: the **element
and attribute names you emit become an API** that the front end depends on. Before
you roll this out, agree on those names with the front‑end team, document them,
version them, and decide who owns changes — renaming an element or attribute later is
a breaking change for every consumer.

## The renderer

The settings here shape the output; to actually *serve* custom‑element markup or JSON
as the site's main content response you also need the separate **Lupus Custom
Elements Renderer** module. Without it, Custom Elements builds the output but doesn't
replace Drupal's main page rendering.
