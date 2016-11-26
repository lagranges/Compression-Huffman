
CFLAGS = -g	# a commenter pour enlever le debug

SRC_PACKAGES = dico.ads dico.adb \
               code_binaire.ads code_binaire.adb \
               file_priorite.ads file_priorite.adb \
               huffman.ads huffman.adb

EXE = exemple_io tp_huffman test_file test_code test_arbre test_dico


all: $(EXE)

tp_huffman: tp_huffman.adb $(SRC_PACKAGES)
	gnatmake $(CFLAGS) $@

test_file: test_file.adb $(SRC_PACKAGES)
	gnatmake $(CFLAGS) $@

test_arbre: test_arbre.adb $(SRC_PACKAGES)
	gnatmake $(CFLAGS) $@

test_code: test_code.adb $(SRC_PACKAGES)
	gnatmake $(CFLAGS) $@

test_dico: test_dico.adb $(SRC_PACKAGES)
	gnatmake $(CFLAGS) $@

exemple_io: exemple_io.adb
	gnatmake $(CFLAGS) $@

clean:
	gnatclean -c *
	rm -f b~* ~*

cleanall: clean
	rm -f $(EXE) exemple_io.txt
	
