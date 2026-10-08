Business Identity gives a Drupal site one central admin page for an organization's identity data — name, contact, address, legal/VAT details, opening hours and social links — and surfaces it through a display block and tokens.

---

Business Identity adds a single settings form at `/admin/config/business/identity` (permission "administer business identity") where an administrator records the company's descriptive, contact, address, legal, e-commerce, review, capacity and opening-hours information into one config object (`business_identity.settings`). Some fields are deliberately read-only mirrors of Drupal core settings (site name, slogan, email, front page, date/time format, timezone), so the page acts as a consolidated overview rather than a second source of truth for those. The collected data is exposed to the front end through a "Business Identity" block (rendered by `templates/block--business-identity.html.twig`), a set of `[business:*]` tokens, and Twig helper functions. Optional country submodules (Germany, Italy) plug region-specific legal fields (VAT identifiers, register numbers, GDPR/e-invoicing) into a "Local Laws" tab via hooks. Note the project is young and partly incomplete: several declared assets (attached libraries), the token/twig service wiring in the base module, and a JSON-LD controller are present in code but not fully wired, so treat advanced pieces as evolving.

---

- Give editors one screen to manage all company/organization identity information instead of scattering it across modules.
- Display the business name, address, phone, email, VAT number and opening hours in a sidebar or footer via the Business Identity block.
- Show a museum's or gallery's address and visiting hours on every page.
- Present a hotel's contact details, address and check-in-relevant hours through the block.
- Publish a shop's location, opening hours and social links in the site footer.
- Surface a public park or facility's contact and hours block on landing pages.
- List departmental/office contact details and social profiles for an organization.
- Reuse the company name and email tokens (mirrored from Site Information) inside content, mails and views.
- Insert `[business:legal_name]`, `[business:tax_id]` / VAT and `[business:address]` tokens into invoices, legal pages or footers.
- Keep a company's social-media URLs (Facebook, X/Twitter, LinkedIn, Instagram, YouTube, Pinterest, TikTok) in one place and render them as icons.
- Record and display structured opening hours per weekday, including closed days.
- Store customer-support email and phone separately from the primary site email.
- Capture legal identity (registered legal name, tax ID/VAT, founding year) for corporate footers or compliance text.
- Configure a promotional "Buy Now" / alternative call-to-action link with label, URL, style and placement flags.
- Track aggregate review ratings and per-platform review URLs (Google, Yelp, Trustpilot, TripAdvisor, etc.) for a reputation badge.
- Record facility capacity data (people capacity, staff size, square footage, parking spaces, meeting rooms).
- Add Germany-specific legal fields (USt-IdNr, Handelsregister number, Impressum, DSGVO/GDPR) with the `business_identity_local_de` submodule.
- Add Italy-specific legal fields (CIN, Partita IVA, SDI code, PEC email, REA/ATECO) with the `business_identity_local_it` submodule.
- Expose a "Local Laws" region selector so multi-country sites can configure each jurisdiction's legal data.
- Provide theme templates access to business data through Twig functions such as `business_name()`, `business_contact()` and `business_address()` (where the base module's Twig extension is enabled).
- Consolidate branding-related pointers (logo location, colors, fonts stored in config schema) for a business overview page.
