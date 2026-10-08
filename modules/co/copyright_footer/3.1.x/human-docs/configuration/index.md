# Configuration

Copyright Footer has no central settings page — you configure it entirely on the
block instance you place. Each block you place can carry its own organization and
years, so a multisite or sectioned site can have several different notices.

## Place the block

1. Log in as a user who can administer blocks and go to **Structure → Block
   layout** (`/admin/structure/block`).
2. Find your theme's **Footer** region (or wherever you want the notice) and click
   **Place block**.
3. In the block picker, choose **Copyright Footer** (listed under the "Custom"
   category).
4. The block's configuration form opens.

## Fill in the fields

All six fields are optional — leave any of them blank and that piece is simply
omitted. With everything empty you still get "Copyright © *(current year)*".

- **Organization name** — the text shown after the year, usually your company or
  site name. Blank means no name is printed.
- **Organization URL** — if you enter a URL here, the organization name becomes a
  link to it. Leave blank for plain text.
- **Year origin (start year)** — the first year of your copyright. Leave it blank
  (or set it to the current year) to print a single year. Set it to an earlier
  year to print a range.
- **Year to date (end year)** — the last year of the range. If you set a start
  year but leave this blank, the current year is used automatically — so
  "2010" as the start gives you "2010-2026" and keeps updating each year.
- **Version** — an optional application/version string. When set, it renders as
  `ver.<version>` after the organization (for example "ver.3.1.1").
- **Version URL** — if you enter a URL *and* a version, the version string links
  there (handy for pointing at a changelog or release notes). It is ignored if the
  version field is empty.

### How the year prints

- Blank start year, or a start year equal to the current year → a single year:
  *Copyright © 2026 …*
- An earlier start year → a range: *Copyright © 2010-2026 …* (with the end year
  filled in automatically when you leave "Year to date" blank).
- To pin a fixed single year, such as a launch year, set both the start and end
  year to the same value.

## Visibility, label, and placement

The block label is **hidden by default**, so only the copyright line shows. Use
the standard block settings on this form to control **visibility** — restrict the
block to specific pages, roles, content types, or languages via core's visibility
conditions — and set the block **weight** in the region to push the notice to the
very bottom of the footer.

## Save

Click **Save block**. The notice appears immediately in the chosen region, and the
year stays current on its own from then on. To change the text later, return to
**Block layout** and edit the block.
