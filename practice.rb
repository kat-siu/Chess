* parent class: Piece
* subclasses:
  * Bishop, Rook, Queen < Sliding Module
  * Knight, King 
  * Pawn

FOR EACH PIECE
- position (instance variable)
- color (instance variable)
- board (instance variable)
- symbol -- Unicode (instance variable)
- valid_move? (takes into account whether the spot is null or has oppenent piece = true -- Piece class method)
  - each individual subclass will have its own moves(method)
  - sliding pieces need move_dirs (method) and piece_in_way? (method)
  - stepping pieces will just use moves (method)
  - pawns need first move?(can be 1 or 2 squares forward) and diagnol_take?(is another piece there)