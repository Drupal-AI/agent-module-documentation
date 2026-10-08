# Configuration

Setting up Taxonomy Term Config Groups has three steps: enable grouping on a
vocabulary, create groups and assign terms, and (optionally but recommended) add fields
to the groups so they actually carry shared settings.

## 1. Enable grouping on a vocabulary

1. Make sure the role doing this has the **administer taxonomy term config groups**
   permission.
2. Go to **Structure → Taxonomy** and edit the vocabulary you want
   (`/admin/structure/taxonomy/manage/{vid}`).
3. Check **"Enable term config groups for this vocabulary"** and save.

Enabling grouping automatically creates a group bundle for that vocabulary (its ID
follows the pattern `vocab_{vid}`) and adds a **Configure term grouping** operation to
the vocabulary. If you later disable grouping, your data is preserved; if you delete
the vocabulary, the module cleans up its groups and bundle for you (it warns you on
deletion).

## 2. Create groups and assign terms

1. Use the vocabulary's **Configure term grouping** operation, or visit
   `/admin/structure/taxonomy/manage/{vid}/grouping` directly.
2. This opens the visual **Terms Icicle** interface, where you can browse the
   vocabulary's hierarchy and **drag / transfer terms between icicles** to assign them
   to groups.
3. Create groups, give them labels, and assign the terms you want to each.
4. **Save** to create or update the underlying `taxonomy_group` entities.

## 3. Add fields to the groups (optional, recommended)

Groups only become useful when they carry settings, which you express as fields on the
group bundle:

1. Go to `/admin/structure/taxonomy-groups/types`.
2. Use **Manage fields** for the bundle created for your vocabulary (the `vocab_{vid}`
   bundle).
3. Add whatever fields express your shared settings — for example a boolean *Show in
   filter*, a numeric *Boost weight*, or an entity reference to a *Landing page*.

Because a group can hold booleans, text, entity references, and more, you can store
"configure once, apply to many terms" values like navigation visibility, a group
landing page or banner, or a mapping to shipping classes and pricing rules.

## 4. Use it in custom code (optional)

If you want site behaviour to react to a term's group, developers can fetch a term's
group with the lookup service `taxonomy_term_config_groups.group_lookup` (it returns
the group for a term, or all groups for a vocabulary) and read the fields on that group
to drive behaviour everywhere the term is used.
