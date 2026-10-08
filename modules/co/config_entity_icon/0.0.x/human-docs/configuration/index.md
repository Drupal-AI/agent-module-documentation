# Configuration

Config Entity Icon needs one deliberate setup step before it does anything: you
tell it **which config entity types** should offer an icon picker. Until you enable
a type here, its edit forms look exactly as they did before.

## Open the settings form

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → User interface → Config Entity Icon**.

## Choose which entity types get an icon picker

The form lists the config entity types available on your site — for example
**Content type**, **Taxonomy vocabulary**, **Menu**, **Media type**, and any custom
config entity types you've defined. Tick each type that should receive an icon
picker, then save.

From then on, when you edit an entity of an enabled type (say, a specific content
type), an **Icon** picker appears on its form. If that form has an *Additional
settings* vertical tab, the picker is placed there automatically; otherwise it
appears inline. Pick an icon from any installed pack, and it is stored as a
third-party setting on that entity — which means it exports and deploys along with
the rest of the entity's configuration.

## Rendering the chosen icon

Choosing an icon stores it; displaying it is up to your theme or code. The module
provides a resolver service, `config_entity_icon.resolver`, that reads and renders
an entity's icon from a Twig template or from PHP. This is a developer step rather
than a UI one — see the module's `agent/` docs or README for the service API.

## Save

Click **Save configuration**. Newly enabled entity types get their icon picker
immediately the next time you open one of their edit forms.
