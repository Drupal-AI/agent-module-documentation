# Configuration

There are two parts to setting this module up: building the initial index, and
switching a View over to use it in place of the slow core contextual filter.

## 1. Build the index

1. Make sure you have some taxonomy terms in place.
2. Go to `/admin/taxonomy_term_parents_reindex`.
3. Click **Reindex** to populate the custom `taxonomy_parents_index` table with every
   term's ancestor IDs.

Access to this form is gated by the module's own permission, so grant it to the roles
that should be allowed to rebuild the index. After the first build, the module keeps
the index current automatically as terms are created, updated, and deleted — you only
need to reindex manually if you want to rebuild from scratch.

## 2. Switch a View over to the index

To replace the *"Has taxonomy term ID (with depth)"* contextual filter in your
Taxonomy term (Content) View with the fast index-backed version:

1. **Remove** the existing *"Has taxonomy term ID (with depth)"* contextual filter.
2. Add a **relationship** called *"Join from taxonomy_index to
   taxonomy_parents_index"*. Tick **Require this relationship** and click **Apply**.
3. Add the **Parent ID** contextual filter (found under the *Taxonomy Parents Index*
   category) and click **Apply**.
4. In that contextual filter's settings, under **When the filter value is NOT in the
   URL**, choose **Provide default value** and set it to **Taxonomy term ID from
   URL**.
5. Under **When the filter value IS in the URL or a default is provided**, check
   **Override title** and set it to `{{ arguments.ptid }}`. Click **Apply**.
6. In the view's header settings, click **Global: Rendered entity - Taxonomy term**.
7. Set the **Taxonomy term ID** to `{{ raw_arguments.ptid }}` and click **Apply**.
8. **Save** the view.

The View now lists content tagged with the term or any of its descendants using the
pre-computed index, avoiding the parent-chain walk that made the core filter slow at
scale.
