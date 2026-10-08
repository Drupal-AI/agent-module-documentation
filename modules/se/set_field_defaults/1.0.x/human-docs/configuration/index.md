# Configuration

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → Field Default Values**, or navigate directly to
   `/admin/config/field-defaults`.

## Define the defaults

On this page you define default values **per field type**. For each field type the
module supports — text, number, link fields and more — set the value you want new
fields of that type to start with. Save the form when you're done.

## How the defaults get applied

The module integrates directly with Drupal's field system. When you next add a new
field of a type you've configured, its default value is pre-filled from your
settings — so you don't have to type it in each time. The pre-filled value is not
locked: you can still adjust it manually during field creation if a particular field
needs a different default.

This keeps your fields consistent across content types while saving the repetitive
work of setting the same default over and over. There are no content or access
implications here — the settings only affect the starting default value offered when
creating new fields.
