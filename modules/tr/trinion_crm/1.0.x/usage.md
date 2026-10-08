<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trinion CRM adds a lightweight sales CRM to Drupal built from node bundles: leads (lead), contacts (contact), companies (kompanii) and deals (sdelki).

---

The module turns ordinary content types into a CRM pipeline. A public contact form submission is captured by `hook_form_alter`/`trinion_crm_contact_form_submit`, which creates a `lead` node from the submitted fields and emails a configurable list of manager users. Leads are then converted into a contact (and optionally a company) through the `/lead-convert` form, and deals (`sdelki`) are numbered automatically per year by `CRMHelper::getNextDocumentNumber()`. Deals can be approved or annulled through an approve endpoint, and every bundle can be exported to a PDF via Dompdf.

Access is layered: list/view of each bundle is gated by four module permissions (`trinion_crm contact/company/lead/sdelki`) enforced in `hook_entity_access`, while the settings form is gated by `administer site configuration`. The PDF export routes (`/pdf/kontakt/{node}`, `/pdf/kompaniya/{node}`, `/pdf/lead/{node}`, `/pdf/sdelka/{node}`) use the `create <bundle> content` permissions. The deal approve endpoint `/utverdit_crm/{node}/{op}` is guarded by a custom access checker (owner or `trinion_base edit all`). Typical setup: enable the module (pulls in `trinion_base`, `contact`, `taxonomy`, `options`), grant the four CRM view permissions plus the relevant `create ... content` permissions to sales roles, and configure the lead-notification recipients and starting deal number at `/admin/config/crm/settings`.

---

- Capture website contact-form submissions as CRM leads automatically
- Email a configured list of managers when a new lead arrives
- Convert a lead into a contact via `/lead-convert`
- Convert a lead into a contact and a new company in one step
- Copy a lead's phone/email onto the new contact and company
- Maintain contacts (`contact` nodes) linked to companies
- Maintain companies (`kompanii` nodes) with phone/email fields
- Track deals (`sdelki`) as a sales pipeline
- Auto-number deals and leads sequentially per calendar year
- Approve a deal via `/utverdit_crm/{node}/1`
- Annul a deal via `/utverdit_crm/{node}/0`
- Restrict deal approval to the responsible user or `trinion_base edit all`
- Export a company record to PDF (`/pdf/kompaniya/{node}`)
- Export a contact record to PDF (`/pdf/kontakt/{node}`)
- Export a lead record to PDF (`/pdf/lead/{node}`)
- Export a deal record to PDF (`/pdf/sdelka/{node}`)
- Gate list/view of each bundle with the four `trinion_crm` permissions
- Set the starting number for deal numbering
- Configure which users receive new-lead notifications
- Look up a contact or company by email or phone via `CRMHelper`
- Normalize phone numbers before lookup
- Show related contacts/deals as extra fields on a company page
- Attach uploaded files to a CRM node via the file-upload form
- Prefill a lead form from an incoming mail node (`?mail=<nid>`)
- Prefill a contact form's company from `?kompaniya=<nid>`
- Default the responsible-user field to the current user on CRM forms
- Integrate with `trinion_tp` to add invoice/quote lists to companies
