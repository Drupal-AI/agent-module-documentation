# Configuration

Block Token has no settings page. Getting a block to appear inside content is a three‑step
flow, and there's a permission detail to understand as well.

## 1. Enable the "Replace tokens" filter on a text format

Block Token creates the tokens, but Token Filter is what turns them into rendered blocks inside
text. So first:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the format(s) that should be able to render block tokens (for example your body/full‑HTML
   format).
3. Under **Enabled filters**, tick **Replace tokens** (provided by Token Filter), then save.

## 2. Flag a block to expose its token

1. Go to **Structure → Block layout** and edit the block you want to embed
   (`/admin/structure/block/manage/<block>`).
2. If you have the **Administer block token** permission, the block form shows a checkbox
   **Create the token for this block**. Tick it and save.
3. After saving, the form shows you the token string to copy. The token name is
   `<provider_module>:<block_id>` — for example `system:navigation`.

Only blocks you flag this way become available as tokens, so you control exactly which blocks
editors can embed.

## 3. Use the token in content

In any field that uses a token‑filter‑enabled format, insert the token where you want the block
to appear:

```
[block_token:system:navigation]
```

On render, Token Filter replaces it with the block's output. The block is rendered through
Drupal's standard block view builder (the normal, escaped render pipeline) and honors its usual
access and visibility settings — so the editor chooses *which flagged block* to embed, but not
its markup. Edit the block once, and every token that references it updates everywhere.

## Permissions

The module defines a single permission:

- **Administer block token** — shows the "Create the token for this block" checkbox on block
  forms.

When the module is enabled, it also sets a custom access check (`block_token_route_access()`) on
two core routes — the **block edit form** and the **block layout listing** — so that they are
reachable by users who have **Administer block token** or **Administer taxonomy**. In other words,
granting **Administer block token** also lets that role reach the block edit form and block layout
listing. Decide which roles receive **Administer block token** with that access in mind, and note
that **Administer taxonomy** holders can reach those block screens too.
