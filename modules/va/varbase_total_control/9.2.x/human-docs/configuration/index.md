# Configuration

Varbase Total Control Dashboard has no settings form. You set it up in three
ways: by granting dashboard access, by customizing the Page Manager page, and by
configuring each dashboard block's settings.

## Grant access to the dashboard

The dashboard is protected by the **Have total control** permission, which is
provided by the Total Control module. Only users with that permission can reach
the dashboard page.

- **The easy way:** apply the module's shipped recipe (`recipes/default`), which
  grants **Have total control** to the `editor`, `content_admin`, `seo_admin`, and
  `site_admin` roles and enables supporting config.
- **The manual way:** go to **People → Permissions**
  (`/admin/people/permissions`) and tick **Have total control** for the roles that
  should see the dashboard.

## Customize the dashboard layout

The dashboard is a two‑column Page Manager page. To change what appears and where:

1. Go to **Structure → Pages** (`/admin/structure/page_manager`) and edit the
   **Total Control Dashboard** page.
2. Add, remove, or rearrange panes in the two‑column variant, or click the cog on
   any pane to configure it.

By default the layout includes the user info block, the Create New Content block
(pre‑set to the `landing_page` and `page` types), a recent‑content Views block,
Quick Links, and the My Site Overview block.

## Configure the dashboard blocks

The module provides four custom blocks. You can configure the instances already
placed on the dashboard (via their cog), or place them on other Panels/Layout/block
regions elsewhere:

- **Varbase Dashboard User** — a summary of the current user. No extra settings.
- **Quick Links** — handy admin links. No extra settings.
- **Create New Content** — one‑click "create" shortcuts. In its settings, choose
  **which content types** appear as create links.
- **My Site Overview** — in its settings you can choose the **content types to
  count**, whether to include **comment counts per type**, and whether to show a
  **spam / unapproved‑comment count**.

## Show a pane only when a module is present

The module includes a visibility condition called **module_enabled**. Add it to
any block or pane and give it a module machine name, and that pane will only render
when that module is enabled — handy for dashboard widgets that depend on an
optional module.

## Charts and styling

The dashboard can render charts through the Charts module (with the C3 library),
whose defaults the module sets during install. Its own dashboard CSS is loaded
only on the dashboard routes, so it won't affect the rest of your admin theme. You
can further customize the underlying lists by editing the Total Control views.
