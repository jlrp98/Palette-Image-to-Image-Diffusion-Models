#!/usr/bin/python

import argparse
import os
from random import shuffle

parser = argparse.ArgumentParser()
parser.add_argument('--folder_path', default='./training_data', type=str,
                    help='The folder path')
parser.add_argument('--test_filename', default='./data_flist/train_shuffled.flist', type=str,
                    help='The output filename.')
parser.add_argument('--mask_filename', default='./data_flist/validation_shuffled.flist', type=str,
                    help='The output filename.')
parser.add_argument('--is_shuffled', default='1', type=int,
                    help='Needed to shuffle')

if __name__ == "__main__":

    args = parser.parse_args()

    # get the list of directories
    dirs = os.listdir(args.folder_path)
    dirs_name_list = []

    # make 2 lists to save file paths
    training_file_names = []
    validation_file_names = []
    test_file_names = []
    mask_file_names = []


    # print all directory names
    for dir_item in dirs:
        # modify to full path -> directory
        dir_item = args.folder_path + "/" + dir_item
        # print(dir_item)

        '''training_folder = os.listdir(dir_item + "/training")
        for training_item in training_folder:
            training_item = dir_item + "/training" + "/" + training_item
            training_file_names.append(training_item)

        validation_folder = os.listdir(dir_item + "/validation")
        for validation_item in validation_folder:
            validation_item = dir_item + "/validation" + "/" + validation_item
            validation_file_names.append(validation_item)
        '''

    for item in os.listdir(args.folder_path + "/input"):
        test_file_names.append(args.folder_path +"/input/"+item)

    for item in os.listdir(args.folder_path + "/mask"):
        mask_file_names.append(args.folder_path +"/mask/"+item)    


    # print all file paths
    for i in test_file_names:
        print(i)
    for i in mask_file_names:
        print(i)

    # This would print all the files and directories

    # shuffle file names if set
    if args.is_shuffled == 1:
        shuffle(training_file_names)
        shuffle(validation_file_names)

    # make output file if not existed
    if not os.path.exists(args.test_filename):
        os.mknod(args.test_filename)

    if not os.path.exists(args.mask_filename):
        os.mknod(args.mask_filename)

    # write to file
    fo = open(args.test_filename + ".flist", "w")
    fo.write("\n".join(test_file_names))
    fo.close()

    fo = open(args.mask_filename + ".flist", "w")
    fo.write("\n".join(mask_file_names))
    fo.close()

    # print process
    print("Written file is: ", args.test_filename, ", is_shuffle: ", args.is_shuffled)
