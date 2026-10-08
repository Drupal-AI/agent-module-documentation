# Configuration

Until you tell it which fields to act on, Entity Field Capitalization does
nothing. This page walks through the settings form.

## Open the settings form

1. Log in as a user with the module's administer permission (an administrator by
   default).
2. Go to **Configuration → Entity Field Capitalization settings**, or navigate
   directly to `/admin/config/field-capitalization-settings`.

## The settings

- **Fields to capitalize** — choose the fields, across any entity type, whose
  values should be capitalized. You can select several. On each save or update of
  an entity, the listed fields have their values transformed so the first letter
  of each word is capitalized.

- **Excluded strings** — a list of words or strings that should be left untouched
  by the automatic capitalization. Add anything that must keep its exact case —
  brand names and terms like *jQuery* are the usual examples — so the module
  doesn't "correct" them.

## How it behaves

The transformation runs during entity **save and update**. That means the value
is stored capitalized, so it appears consistent everywhere the field is used, not
just in one display. Existing content isn't rewritten until it is next saved.

## Save

Click **Save configuration**. From then on, saving or updating an entity applies
the capitalization to the fields you selected, skipping any excluded strings.
