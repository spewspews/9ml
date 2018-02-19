open Util

let opts = []
let usage = Printf.sprintf "Usage: %s [ files... ]" argv0
let add_input file = in_files := file :: !in_files

let compile file in_chan = begin
  let lexbuf = Lexing.from_channel in_chan in
  let _ = Parser.prog Lexer.token  lexbuf in
  ()
end

let () = begin
  Arg.parse opts add_input usage;
  match List.rev !in_files with
  | [] -> compile "<stdin>" stdin
  | files -> List.iter (fun file -> compile file (open_in file)) files;
  exit 0;
end
