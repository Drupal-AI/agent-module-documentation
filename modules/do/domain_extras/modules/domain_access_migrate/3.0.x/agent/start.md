# Migrate Domain Access (domain_access_migrate) 3.0.x

Drupal 7 migrate source plugins that read Domain Access node and user assignments for upgrade to the Drupal 10/11 Domain suite.

## Facts

- **Dependencies:** `drupal:migrate` (core Migrate) only. No dependency on the base `domain` modules.
- **Package:** Migration. `core_version_requirement: ^10.2 || ^11`.
- **Routes:** none. **Services:** none. **Permissions:** none. **Config:** none. **Hooks:** none.
- **Plugins (implements core `@MigrateSource`, defines no new plugin type):**
  - `d7_node_domain_access` — `NodeDomainAccess` (`src/Plugin/migrate/source/d7/NodeDomainAccess.php`), `source_module = node`, extends `Drupal\node\Plugin\migrate\source\d7\Node`.
  - `d7_user_domain_access` — `UserDomainAccess` (`src/Plugin/migrate/source/d7/UserDomainAccess.php`), `source_module = user`, extends `Drupal\user\Plugin\migrate\source\d7\User`.

### What each plugin reads and produces

- **`NodeDomainAccess`** (`prepareRow()`):
  - Adds source field `domain_access_node`: queries D7 `domain_access` where `realm = domain_id` and `nid = <nid>`, then for each `gid` looks up `machine_name` in the D7 `domain` table, producing `[['target_id' => <machine_name>], ...]`.
  - Sets `domain_all_affiliates = 1` when a `domain_access` row with `realm = domain_site` exists for the node (`getDomainSites()`).
  - Sets `domain_source` to a single domain `machine_name` resolved from the D7 `domain_source` table (`getDomainSourceTargetId()`); skips ids that no longer resolve.
  - `query()` is passed through unchanged from the parent `d7_node` source; only `fields()` and `prepareRow()` are extended.
- **`UserDomainAccess`** (`prepareRow()`):
  - Adds source field `domain_access_user`: queries D7 `domain_editor` for `domain_id` where `uid = <uid>`, resolves each to a `domain` `machine_name`, producing `[['target_id' => <machine_name>], ...]`.
  - `query()` passed through unchanged from the parent `d7_user` source.

## How to use

No UI or config. Reference the source ids from migration definitions (YAML or generated migrations) that run against a D7 database source:

- `source:\n  plugin: d7_node_domain_access` — then map `domain_access_node` (and `domain_source`, `domain_all_affiliates`) onto the destination node's Domain Access / Domain Source fields.
- `source:\n  plugin: d7_user_domain_access` — then map `domain_access_user` onto the destination user's Domain Access field.

The emitted `target_id` arrays are shaped for entity-reference domain fields on the destination site. Enable the base Domain / Domain Access modules on the destination so those fields exist. No `agent/*.md` beyond this file.
