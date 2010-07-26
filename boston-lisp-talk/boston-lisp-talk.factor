! Copyright (C) 2010 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: slides help.markup math math.private kernel sequences
slots.private see help help.topics combinators generalizations
help.vocabs formatting ;
IN: boston-lisp-talk

CONSTANT: boston-lisp-slides
{
    { $slide "Factor"
        "Dynamic, object-oriented, functional, stack-based language"
        "Open source (BSD license)"
        "Influenced by Forth, Lisp, C++, Smalltalk"
        "Terminology mostly from Forth and Joy"
        "Blurs the line between language and library"
        "Interactive development"
    }

    { $slide "Part 1 - language overview" }

    { $slide "Example"
        { $code
            "USING: io.encodings.ascii math.parser"
            "splitting ;"
            ""
            ""
            "\"prices.txt\" ascii file-lines"
            "[ \" \" split ] map"
            "[ last string>number ] map"
            "[ 10 > ] filter"
            "sum ."
        }
    }
    { $slide "Data types"
        { "Number tower (integer, ratio, float, complex)"
            { $code
                "3 100 ^ ."
                "4232 88 / ."
                "2 sqrt ."
                "-5 log ."
            }
        }
        { "Booleans"
            { $code
                "t"
                "f"
            }
        }
    }
    { $slide "Data types"
        { "Unicode strings"
            { $code
                "\"здравствуйте\" >upper ."
            }
        }
        { "Arrays"
            { $code
                "{ \"Cat\" t 24 } reverse ."
            }
        }
    }
    { $slide "Data types"
        { "Hashtables"
            { $code
                "H{"
                "    { \"Sandwich\" 9 }"
                "    { \"Burger\" 10 }"
                "    { \"Fish and chips\" 12 }"
                "} values sum ."
            }
        }
    }
    { $slide "Data types"
        { "Tuples"
            { $code
                "TUPLE: person first last age ;"
                ""
                ""
                "person new"
                "\"Slava\" >>first"
                "\"Pestov\" >>last"
                "26 >>age"
            }
        }
    }
    { $slide "Data types"
        { "Quotations (anonymous functions)"
            { $code "10 [ 5 7 [a,b] random ] replicate ." }
            { $code "{ 1 2 3 } 5 '[ _ + ] map ." }
        }
    }
    { $slide "Code is data"
        { "A stack program is a list of literals and words (functions). Literals are pushed on the stack, words are executed" }
        {
            { "Use " { $link see } " to look at definitions" }
            { $code "\\ sq see" }
        }
        {
            { "Integrated " { $link help } }
            { $code "\\ filter help" }
        }
    }
    { $slide "Data flow"
        "Previous code snippets: “pipeline code”"
        "What about more complex dataflow?"
        { "In order of preference:"
            { $list
                "Dataflow combinators (higher order functions)"
                "Lexical variables"
                "Stack shuffling"
            }
        }
    }
    { $slide "Data flow combinators"
        {
            { { $link cleave } ": applying several quotations to a single value" }
            { $code "{ [ first>> ] [ last>> ] [ age>> ] } cleave" }
        }
        {
            { { $link spread } ": applying several quotations to several values" }
            { $code "{ [ 1 head ] [ 1 head ] [ 21 > ] } spread" }
        }
        {
            { { $link napply } ": applying several quotations to one value" }
            { $code "[ . ] 3 napply" }
        }
    }
    { $slide "Lexical variables"
        "TODO"
    }
    { $slide "Stack shuffling"
        "Lower-level Forth/PostScript-style dataflow"
        { "Other than " { $link dup } " and " { $link drop } ", use is discouraged" }
    }
    { $slide "Control flow"
        "Combinators (higher order functions)"
        { "Conditional execution: " { $link if } ", " { $link cond } }
        { "Iteration over collections: " { $link map } ", " { $link filter } ", etc" }
        { "There is also " { $link while } }
        { "Everything boils down to " { $link if } " and recursion" }
    }
    { $slide "Vocabularies"
        "A vocabulary is a set of words"
        "Each vocabulary is stored in a directory on disk"
        "Vocabularies are searched for in vocabulary roots"
        { "Example: " { $vocab-link "roman" } " vocabulary"
            { $list
                { "Code: " { $snippet "basis/roman/roman.factor" } }
                { "Documentation: " { $snippet "basis/roman/roman-docs.factor" } }
                { "Unit tests: " { $snippet " basis/roman/roman-tests.factor" } }
            }
        }
    }
    { $slide "Using a vocabulary"
        { "Each file starts with a " { $snippet "USING:" } " list and an " { $snippet "IN:" } " form" }
        "To use a vocabulary, include it in this list"
        { "The " { $link about } " word gives an overview of a vocabulary"
            { $code "\"io.monitors\" about" }
        }
    }

    { $slide "Part 2 - the environment" }

    { $slide "Interactive development"
        "Programming is hard"
        "...Let's play Tetris!"
        { $vocab-link "tetris" }
        { "Edit " { $vocab-link "tetris.tetromino" } " while its running" }
    }
    { $slide "Removing definitions"
        "In most dynamic languages, loading a source file == copy and paste into REPL"
        "This is wrong!"
        "Removing definitions from a source file and reloading it should remove them from the image"
        { $code "USE: acme.frobnicate" }
    }
    { $slide "Compiler errors"
        { "First vocabulary defines a word:" { $code "USE: acme.widgets.supply" } }
        { "Second vocabulary uses above word:" { $code "USE: acme.widgets.factory" } }
        { "If I add or a parameter, the compiler tells me to update code" }
    }
    { $slide "Macros"
        { "Macros can be used for compile-time evaluation, or variable-arity words" }
        { "Number of inputs and outputs can depend on a literal input parameter" }
        { "Examples: " { $link printf } ", " { $link ndrop } }
    }
    { $slide "Inlining and recompilation"
        { "First vocabulary with a couple of constants:" { $code "USE: planet.earth.constants" } }
        { "Second vocabulary uses these constants:" { $code "USE: planet.earth.physics" } }
        {
            "Constant folding across source file boundaries!"
            { $code "\\ earth-density ssa." }
        }
    }
    { $slide "Tuple reshaping"
        { "Vocabulary defines a data type:" { $code "USE: planet.data" } }
        {
            { "Let's make an instance of this type" }
            { $code
                "planet new"
                "    earth-mass >>mass"
                "    earth-radius >>radius"
                "    24 >>day-length"
                "    365 >>year-length"
            }
        }
        { "Adding, re-arranging, removing slots updates instances" }
    }

    { $slide "Part 3 - meta-programming" }
    
    { $slide "Part 4 - low-level features" }

    { $slide "Part 5 - the implementation" }

    { $slide "The VM"
        "Lowest level is the VM: ~12,000 lines of C"
        "Generational garbage collection"
        "Non-optimizing compiler"
        "Loads an image file and runs it"
        "Initial image generated from another Factor instance:"
        { $code "\"x86.32\" make-image" }
    }
    { $slide "The core library"
        "Core library, ~9,000 lines of Factor"
        "Source parser, arrays, strings, math, hashtables, basic I/O, ..."
        "Packaged into boot image because VM doesn't have a parser"
    }
    { $slide "The basis library"
        "Basis library, ~80,000 lines of Factor"
        "Bootstrap process loads code from basis, runs compiler, saves image"
        "Loaded by default: optimizing compiler, tools, help system, UI, ..."
        "Optional: HTTP server, XML, database access, ..."
    }
    { $slide "Two compilers"
        "Base compiler for listener interactions, and bootstrap"
        "Optimizing compiler for word definitions"
    }
    { $slide "Base compiler"
        "Glues together chunks of machine code"
        "Most words compiled as calls, some primitives inlined"
    }
    { $slide "Optimizing compiler"
        "Static stack effects let us convert Factor code to SSA form"
        "Makes high-level language features cheap to use"
        "Eliminate redundant method dispatch by inferring types"
        "Eliminate redundant integer overflow checks by inferring ranges"
        "Eliminate redundant memory allocation (escape analysis)"
        "Eliminate redundant loads/stores (alias analysis)"
        "Eliminate redundant computations (value numbering)"
    }
    { $slide "Project infrastructure"
        { $url "http://factorcode.org" }
        { $url "http://concatenative.org" }
        { $url "http://docs.factorcode.org" }
        { $url "http://planet.factorcode.org" }
        { $url "http://twitter.com/FactorBuilds" }
        "HTTP server, SSL, DB, Atom, OAuth..."
    }
    { $slide "Project infrastructure"
        "Build farm, written in Factor"
        "10 platforms"
        "Builds Factor and all libraries, runs tests, makes binaries"
        "Good for increasing stability"
    }
    { $slide "Community"
        "#concatenative irc.freenode.net: 60-70 users"
        "factor-talk@lists.sf.net: 300 subscribers"
        "Factor standard library is the work of 50 people"
    }
    { $slide "Questions?"
        { $url "http://factorcode.org" }
    }
}

: boston-lisp-talk ( -- )
    boston-lisp-slides slides-window ;

MAIN: boston-lisp-talk
