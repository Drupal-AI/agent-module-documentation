# Configuration

There is no central settings screen for this module. You configure it **per taxonomy
term**: each term edit page gains a field naming the users (and/or roles) who are
allowed to edit nodes tagged with that term.

## Set the allow-list on a term

1. Go to **Structure → Taxonomy**, choose a vocabulary, and edit a term
   (`/taxonomy/term/{tid}/edit`).
2. In the term form, fill in the **users that have edit access** field with the
   people who should be allowed to edit content carrying this term.
3. Save the term. From now on, the node edit *form* for any node that references this
   term is restricted to the users/roles you listed — other users are blocked from
   the form.

Repeat for each term whose tagged content you want to scope. A node with no
restricted terms behaves normally.
