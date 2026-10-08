# Configuration

Entity Usage Light is configured in two places: a central settings page where you
switch it on per entity type, and each bundle's edit form where you choose what the
Usage tab should detect.

## 1. Activate the module per entity type

1. Log in as an administrator.
2. Go to **Configuration → Content authoring → Entity Usage Light settings**.
3. Activate the module for the entity types you want the Usage tab on — for example
   *Content* (nodes).

## 2. Choose the detectable entity types per bundle

1. Open a bundle's configuration/edit form — for example the **Article** content
   type at **Structure → Content types → Article → Edit**.
2. Select which **detectable entity types** the Usage tab should look for on this
   bundle. The classic choice is *Media*, so the Usage tab lists all media a node
   uses — including media embedded in CKEditor fields, in entity reference fields,
   and inside paragraphs.
3. Save the bundle.

Repeat for each bundle where you want the Usage tab.

## Using the Usage tab

Open an entity of a configured bundle and click its **"Usage"** local task tab. The
tab lists all referenced entities of the types you selected. Entity Usage Light
does not store usage history — it builds the list on demand from the entity's
current references. If the bundle has revisions enabled, you can also view usage per
revision (this is a work in progress).

## Permission

Access to the Usage tab is governed by the module's permission. Grant it to the
appropriate roles on **People → Permissions** (`/admin/people/permissions`).
