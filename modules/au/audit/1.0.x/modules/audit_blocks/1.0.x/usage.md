Scores block configuration: placement, cache settings, disabled blocks, and custom block types.

---

Registers the `blocks` analyzer (`BlocksAnalyzer`, weight 2), depending on core `block`. It inspects placed block instances and custom block types, flagging cache-configuration problems and disabled-but-placed blocks, and lists an inventory of block types and instances. Scored sections cover cache configuration; the rest are informational.

---

- Find placed blocks with poor or missing cache configuration.
- List disabled blocks that are still configured in a region.
- Inventory all custom block types and block instances.
- See a per-check score circle for block cache health on the detail page.
- Run headless: `drush audit:run blocks --format=json`.
- Filter to cache issues: `drush audit:run blocks --filter="code:CACHE"` after discovering codes via `audit:filters blocks`.
- Include block health in the overall Project Score (weight 2 by default).
- Requires core Block module; enable with `drush en audit_blocks`.
