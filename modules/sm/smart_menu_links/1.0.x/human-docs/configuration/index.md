# Configuration

Smart Menu Links are defined and managed from the **Structure** menu after you
enable the module. The idea is to pair a smart menu link with a View that uses a
contextual filter (argument) pulled from the path.

## Define a smart menu link

1. Log in as a user with the module's administration permission (granted at
   **Administration → People → Permissions** under the Smart Menu Links section).
2. Go to **Structure** and open the Smart Menu Links administration page.
3. Add a new smart menu link and fill in its resolution rules:
   - **Which part of the path to use** — tell the link which segment of the current
     path holds the argument (for example the event ID). This is the value carried
     into the target View's contextual filter.
   - **Entity type and bundle to validate against** — the entity type and bundle
     the resolved target must be, so the link only points at valid content.
   - **Workflow states** *(optional)* — one or more states the referenced entity
     must be in for the link to appear. Use this to show different links at
     different points in an entity's life cycle.

## After adding a link

A newly created smart menu link may not appear until you **clear the site cache**
(`drush cr`, or *Configuration → Development → Performance → Clear all caches*).
The maintainers describe this as a known limitation for freshly added links.

## How the links behave

Each link resolves at request time from the current path, validates the target
against the entity type/bundle (and any workflow states) you configured, and then
respects that target entity's access — a link to content a visitor is not allowed
to see will behave accordingly. This means you build one menu item per related View
and it works across every entity of that type, preserving the contextual argument
as visitors move between listings.
