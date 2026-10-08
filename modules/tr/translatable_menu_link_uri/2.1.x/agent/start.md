# translatable_menu_link_uri — agent start

Makes a `menu_link_content` item's destination translatable per language by adding a
translatable `link_override` base field, then swapping it into the rendered menu URL for the
current translation. Intended for **external** links. Depends on core `menu_link_content` and
`content_translation`. No admin settings form (`configure` is null).

- Make menu link URLs translatable per language + translate a link's destination →
  [configure/translatable_menu_link_uri.md](configure/translatable_menu_link_uri.md)
