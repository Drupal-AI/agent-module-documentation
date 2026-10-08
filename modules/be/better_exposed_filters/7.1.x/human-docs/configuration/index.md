# Configuration

Better Exposed Filters has no global settings page. You configure it **per view
display**, inside the Views UI — so a view needs at least one exposed filter,
sort, or pager before BEF has anything to improve.

## Turn BEF on for a view

1. Edit the view at **Structure → Views → (your view)**
   (`/admin/structure/views/view/<id>`).
2. Make sure the display already has an **exposed** filter, sort, or pager. (You
   expose a filter by editing it and ticking **Expose this filter to visitors**.)
3. In the display's settings, find the **Exposed form** section and click the
   value next to **Exposed form style**.
4. Choose **Better Exposed Filters** and apply.
5. Back in the **Exposed form** section, click **Settings** (next to the style you
   just chose) to open the BEF options form.

## General options

The BEF settings form opens on a general section that applies to the whole exposed
form:

- **Auto‑submit** — the view refreshes as soon as a visitor changes a filter, with
  no need to press a button. This is what gives a "search as you type/click" feel.
- **Hide the submit button** — usually paired with auto‑submit so there is no
  redundant Apply button. There is also an option to *allow* hiding it.
- **Secondary / advanced options** — tuck less‑important filters into a collapsible
  "Advanced options" group so the main form stays short.
- **Reset button** — offer a link/button that clears the exposed filters (via AJAX
  when the view uses AJAX).

## Per‑filter widget options

Below the general section, each exposed filter gets its own block where you pick a
**widget**:

- **Default** — the standard select box (no change).
- **Checkboxes / Radio buttons** — render the options as checkboxes (multi‑value)
  or radios (single value).
- **Links** — a row of clickable links, the classic facet look.
- **Single on/off** — a single checkbox that toggles one value.
- **Hidden** — keep the filter's value active but hide the control from visitors.
- **Number** — a plain number field for numeric filters.
- **Sliders** — a noUiSlider range slider; you set the min, max, and step.
- **Date picker** / **Datetime picker** — calendar pickers for date and datetime
  filters.

Depending on the widget you choose, extra options appear, such as: **select
all/none** links for checkbox lists, a **soft limit** with "show more / show less"
labels, a fixed‑height **scrollable** container for long lists, a **collapsible
fieldset**, and the ability to **rewrite** the visible option labels.

## Per‑sort and per‑pager options

If the view exposes a **sort** or a **pager** (items per page), each of those gets
its own widget choice too: leave it as the **Default** select, or render it as
**Links** or **Radio buttons**.

## Save and deploy

Click **Apply** on the BEF settings form, then **Save** the view. All of these
settings are stored inside the view's exposed‑form configuration, so they are part
of the view itself — `drush config:export` captures them and they deploy between
environments right along with the view.
