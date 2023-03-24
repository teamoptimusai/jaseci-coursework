import {*} with "./graph.jac";
import {*} with "./util.jac";

walker init {
    root {
        spawn here ++> node::family_root;
        spawn here walker::load_familytree;
    }
}