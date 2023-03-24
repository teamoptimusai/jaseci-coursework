walker load_familytree {
    has family_tree_json = "familytree.json";
    has family_members = [];
    has family_member_nodes = [];

    root: take --> node::family_root;
    family_root {
        family_members = file.load_json(family_tree_json);
        for family_member in family_members {
            person_node = spawn here ++> node::person(
                id = family_member["uid"],
                name = family_member["name"],
                date_of_birth = family_member["date_of_birth"],
                profession = family_member["profession"],
                gender = family_member["gender"],
                deceased = family_member["deceased"],
                children = family_member["children"],
                spouse = family_member["spouse"]
            );
            family_member_nodes.l::append(person_node);
        }
        take --> node::person;
    }
    person {
        children_ids = here.children;
        spouse_id = here.spouse;
        for family_member_node in family_member_nodes {
            if family_member_node.id in children_ids {
                here +[children]+> family_member_node;
            }
            if family_member_node.id == spouse_id {
                here +[married]+> family_member_node;
            }
        }
    }
}

