    Compression-Huffman

        Le TP d'Algorithme et Programmation

    Introduction

        Ce TP est pour objectif de implementer une programme en Ada de compression 
    ou décompression d'un text en utilisant arbre Huffman.

    Fichiers
        
        Source code (*.adb, *.ads)
        Ce README
        Makefile

    Compilation et lancement des test
        Pour compresser/décompresser un fichier:
            make tp_huffman
            ./tp_huffman -c nom_fichier nom_fichier_compressé 
            (example ./tp_huffman -c Tests/francais.txt francais.txt.comp)
            ./tp_huffman -d nom_fichier nom_fichier_décompressé
            (example ./tp_huffman -d francais.txt.comp francais.txt.comp.txt)
        Pour vérifier:
            cd Test
            ./tests_huffman.sh nom_fichier
    Authors
        Iyed
        Tuan


    
    
