# Configuration

Setting this module up has two stages: on the **settings page** you tell it which
content-type/field combinations should get creation links, and then in **Block layout**
you place the block(s) it generates.

## 1. Choose the content-type / field combinations

1. Log in as a user with the **Administer taxonomy** permission.
2. Go to **Configuration → Content authoring → Create Content with Category**, or
   navigate directly to `/admin/config/content/createcontentwithcategory`.
3. Select the **content type + taxonomy-reference field** combination(s) you want links
   for. For each combination you pick, the module will read the terms from the
   vocabulary that field references and build a set of "create in category X" links.
4. Save the settings.

You can configure more than one combination, and a field that references multiple
vocabularies is supported — the links cover the terms available to that field.

## 2. Place the block

For each configured combination the module exposes a **block** whose links open the
node-add form for that content type with the chosen field pre-filled to the clicked
term:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the Create Content with Category block for your combination and **Place block**
   in the region you want (a sidebar is typical).
3. Configure the block's visibility as usual, then save the block layout.

## How the links behave

Each link points at the standard **Add content** form for the content type, with a
Prepopulate query parameter carrying the term ID — so opening the link lands the editor
on a new node form with that category already selected in the reference field. Because
the target is the normal node-add form, Drupal's usual create-content access checks
still apply: a user who cannot create that content type will be stopped by core when
the form loads.

> **Note on block visibility:** this release has a known issue in the block's access
> check — the code that is meant to limit the block to users who can create the target
> content type does not evaluate that permission as intended. Don't rely on the block's
> own access to hide it from users who shouldn't create content; instead control who
> sees it with the block's standard **visibility** settings (for example by role), and
> rest assured that the underlying node-add form still enforces core's create-content
> permission regardless.

## Verify it worked

Place the block, view a page that shows it, and click one of the category links. You
should land on the **Add content** form for the configured content type with the
matching taxonomy term already selected in the reference field.
