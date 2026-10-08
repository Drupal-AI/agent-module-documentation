# Configuration

Castorcito is configured by building and managing **components**, then assembling
them into content. There is no single settings form of tunables; instead you work
from the component collection.

## Manage your components

1. Log in as a user with permission to administer Castorcito components.
2. Open the **Castorcito component collection** — the
   `entity.castorcito_component.collection` route. This is the listing of every
   `castorcito_component` you have defined.

From here you create new components, edit existing ones, and organize them. Each
component is a highly customizable, reusable building block rendered with SDC —
you configure its visual presentation without needing to write code.

If you enabled the **base pack** or **advanced pack** submodules, you can install
their ready-made components (accordion, banner, card, carousel, timeline, and so
on) rather than starting from scratch, then adjust them to match your branding.

## Assembling components into content

Because Castorcito stores component data in a JSON field, you can attach it to any
content entity — nodes, users, taxonomy terms. Add the Castorcito field to the
entity type you want to build with, then, when creating content, assemble the page
from your components.

## Permissions

Castorcito provides its own permissions to control who may manage components and
build content with them. Review them under **People → Permissions** and grant them
only to trusted content-building roles.

## Learning the components

The maintainers point to the
[project website](https://www.drupal.org/project/castorcito) as the best place to
see each component explained in detail with examples — well worth reading
alongside this admin walkthrough.
