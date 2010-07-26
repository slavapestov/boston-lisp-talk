! Copyright (C) 2010 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: slides help.markup math math.private kernel sequences
slots.private see help help.topics combinators generalizations
help.vocabs formatting help.syntax dice ;
IN: boston-lisp-talk

CONSTANT: boston-lisp-slides
{
    { $slide "Factor"
        "Dynamic, object-oriented, functional, stack-based language"
        "Open source (BSD license)"
        "Influenced by Forth, Lisp, C++, Smalltalk"
        "Terminology mostly from Forth and Joy"
        "Blurs the line between language and library"
    }

    { $slide "Part 1 - language overview"
        "Data types"
        "Data flow"
        "Control flow"
        "Code organization"
    }

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
            "Words are defined with special syntax"
            { $code
                ": mean ( seq -- n ) dup sum swap length / ;"
            }
        }
        {
            { "Use " { $link see } " to look at word definitions" }
            { $code "\\ mean see" }
        }
        {
            { "Integrated " { $link help } }
            { $code "\\ length help" }
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
    { $slide "Lexical variables, stack shuffling"
        "Lower-level Forth/PostScript-style dataflow"
        { "Other than " { $link dup } " and " { $link drop } ", use is discouraged" }
        { "Lexical closures supported, see " { $vocab-link "locals" } }
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

    { $slide "Part 2 - the environment"
        "Exploring code"
        "Reloading code"
        "Changing code and data"
    }

    { $slide "Exploring code"
        { "Listing words in a vocabulary:"
            { $code "\"io.monitors\" about" }
        }
        { "Cross-referencing:"
            { $code "\\ exists? usage." }
        }
    }

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
        { $vocab-link "acme.frobnicate" }
    }
    { $slide "Compiler errors"
        "Factor checks stack height at compile time"
        { "First vocabulary defines a word: " { $vocab-link "acme.widgets.supply" } }
        { "Second vocabulary uses above word: " { $vocab-link "acme.widgets.factory" } }
        { "If I add or a parameter, the compiler tells me to update code" }
    }
    { $slide "Inlining and recompilation"
        { "First vocabulary with a couple of constants: " { $vocab-link "planet.earth.constants" } }
        { "Second vocabulary uses these constants: " { $vocab-link "planet.earth.physics" } }
        {
            "Constant folding across source file boundaries!"
            { $code "\\ earth-density ssa." }
        }
    }
    { $slide "Tuple reshaping"
        { "Vocabulary defines a data type:" { $vocab-link "planet.data" } }
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
    }
    { $slide "Tuple reshaping"
        { "Adding, re-arranging, removing slots updates instances" }
        { "How does it work?"
            { $list
                "Objects are not hashtables; slot access is very fast"
                "Redefinition walks the heap; expensive but rare"
            }
        }
    }

    { $slide "Part 3 - meta-programming"
        "Macro words"
        "Parsing words"
        "Examples"
    }

    { $slide "Macro words"
        { "Macros can be used for compile-time evaluation, or variable-arity words" }
        { "Number of inputs and outputs can depend on a literal input parameter" }
        { "Examples: " { $link printf } ", " { $link ndrop } }
    }

    { $slide "Parsing words"
        { "New words are defined with " { $link POSTPONE: : } }
        "This is “just” a library word"
        "Only real syntax is whitespace-separated words and numbers"
        { "Parsing word example: " { $link POSTPONE: DICE: } }
        { "Usage example:"
            { $code "standard-dice-roll ." }
        }
        { "Demonstrates extensibility of " { $link see } }
    }

    { $slide "Help system"
        {
            "Let's document the dice vocabulary:"
            { $code
                "\"dice\" scaffold-help"
            }
        }
        {
            "Help system is built in Factor:"
            { $list
                { $link POSTPONE: HELP: } " parsing word"
                "Markup language: symbols and nested arrays"
            }
        }
    }

    { $slide "Parsing and printing"
        { "Parsing s-expressions with PEGs: "
            { $vocab-link "s-exp.parser" }
        }
        { "Converting s-expressions to XML with XML literals: "
            { $vocab-link "s-exp.to-xml" }
        }
        { "Example:"
            { $code
                "\"(when (< stock-price 100) (buy shares))\""
                "parse-s-exp s-exp>xml pprint-xml"
            }
        }
    }

    { $slide "Part 4 - low-level features"
        "C library interface"
        "Packed binary data"
    }
    
    { $slide "C library interface"
        "Supports structs, function pointers, callbacks"
        {
            "Very simple example:"
            { $code
                "FUNCTION: int getuid ( ) ;"
                "getuid ."
            }
        }
        "All I/O and user interface stuff done via FFI, rather than VM primitives"
        "Cocoa, Fortran, COM FFIs are built on top"
    }

    { $slide "Specialized arrays and SIMD"
        { "Polymorphic arrays and generic arithmetic is inefficient"
            { $code "\\ convert-image ssa." }
            { $code "benchmark-1" }
        }
        { "Compiler generates efficient code for specialized arrays"
            { $code "\\ convert-image-specialized ssa." }
            { $code "benchmark-2" }
        }
        { "Explicit SIMD is even faster"
            { $code "\\ convert-image-simd ssa." }
            { $code "benchmark-3" }
        }
    }

    { $slide "Part 5 - the implementation"
        "VM"
        "Compiler"
        "Library"
    }

    { $slide "The VM"
        "Lowest level is the VM: ~16,000 lines of C++"
        "Generational mark-compact garbage collection"
        "Loads an image file and runs it"
    }
    { $slide "Native code compilation"
        { "Base compiler for listener interactions, and bootstrap"
            { $list
                "Glues together chunks of machine code"
                "Most words compiled as calls, some primitives inlined"
            }
        }
        { "Optimizing compiler for word definitions"
            { $list
                "Static stack effects map Factor code to SSA form"
                "Makes high-level language features cheap to use"
            }
        }
    }
    { $slide "Optimizing compiler"
        "Optimizes method dispatch (type propagation)"
        "Optimizes integer overflow checks (range propagation)"
        "Optimizes memory allocation (escape analysis)"
        "Optimizes loads/stores (alias analysis)"
        "Optimizes computations (value numbering)"
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
    }
    { $slide "Community"
        "#concatenative irc.freenode.net: 60-70 users"
        "factor-talk@lists.sf.net: 300 subscribers"
        "Factor standard library is the work of 50 people"
        "People are either just dabbling or using it for casual scripting, no serious commercial use yet"
    }
    { $slide "Questions?"
        { $url "http://factorcode.org" }
    }
}

: boston-lisp-talk ( -- )
    boston-lisp-slides slides-window ;

MAIN: boston-lisp-talk
