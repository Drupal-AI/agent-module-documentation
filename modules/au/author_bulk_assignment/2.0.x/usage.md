<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Author Bulk Assignment adds a Views bulk operation that reassigns the author of selected content to another account.

---

The need arrives with a departure. Someone leaves, their account has to go or be blocked, and four hundred nodes have them as author — which matters because "own content" permissions key off authorship, because the byline is published, and because deleting the account offers the destructive shortcut of reassigning everything to Anonymous, which loses the record entirely (`prevent_user_delete_reassign`, wave 76, exists to remove exactly that option). Reassigning deliberately to a named successor or an archive account keeps the content editable and honest. The same operation covers a reorganisation, a migration that landed everything under one account, and a section handed from one team to another. Version **2.0.0** on core `^10 || ^11`, depending on core `views`, with an `assign author to selected content` permission and a separate administrative one for the settings. Three things to think about, because this is a bulk write to a field with consequences. **The byline is published** — reassigning changes what readers are told about who wrote something, which is an editorial and sometimes an ethical decision rather than a data-cleanup one. **Revisions carry their own author**, so reassigning the node does not rewrite its history, and the departed user remains in the revision log — usually correct, and worth knowing before someone assumes otherwise. And **"own content" permissions follow the change**, so the new author gains edit and delete rights over everything reassigned, which is the point and is worth checking against who that account belongs to.

---

- Reassign a departing employee's content.
- Move content to an archive account.
- Fix a migration that used one author.
- Hand a section to another team.
- Reassign before deleting an account.
- Avoid orphaning content to Anonymous.
- Transfer authorship after a reorganisation.
- Reassign a contractor's articles.
- Bulk-change an author across a view.
- Support an offboarding process.
- Reassign content to a successor.
- Fix incorrect authorship after an import.
- Move authorship to a team account.
- Support a records-retention step.
- Reassign a filtered set of nodes.
- Transfer ownership of a microsite.
- Consolidate content under one author.
- Support an editorial handover.
