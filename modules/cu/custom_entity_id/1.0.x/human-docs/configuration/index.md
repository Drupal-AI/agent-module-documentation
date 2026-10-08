# Configuration

Custom Entity Id must be configured before it does anything: you tell it which entity
types may accept custom IDs, and you grant the permission that reveals the field.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to the module's settings form (route `custom_entity_id.settings`).

## Choose which entity types allow custom IDs

On the settings form, enable custom IDs for the entity type(s) where you need them.
Until a type is enabled here, the custom‑ID field will **not** appear on that type's
create form — this is why configuration is a required first step. Enable it only for
the types you genuinely need, and consider turning it back off once a migration or
data‑transfer task is finished.

Save the form to apply your choices.

## Grant the permission

Custom Entity Id provides its own permission for using the custom‑ID field, and it is
marked *restricted* for good reason — assigning primary keys by hand is powerful and
easy to get wrong. At **People → Permissions**, grant it only to the specific,
trusted roles that need it (typically a migration or administrator role), and revoke
it when the task is done.

## Use it responsibly

- **Avoid collisions.** The module rejects an ID that already exists, but you should
  still choose IDs deliberately.
- **Mind the sequence.** Picking an ID above the current maximum can jump the
  auto‑increment sequence, so future auto‑assigned IDs skip ranges — anything assuming
  IDs are dense or monotonic may be surprised.
- **Think about enumeration.** Predictable IDs can make content easier to enumerate;
  weigh that where it matters.
- **Prefer Migrate for bulk work.** For anything repeatable or large, use Drupal's
  Migrate system, which sets IDs as part of a mapped, rollbackable process. Reserve
  this module for a small number of hand‑created records or a short migration window.
