#!/bin/bash 

# Usage:
# ./extract_feat_hm.sh
# where proc_split indicates the last a few digits of the image IDs.
# For example, proc_split can go from 000 to 999, when proc_split=000,
# images with name *000.jpg will be processed.
# Hence, you can submit 1000 jobs in parallel to extract the features
# for the entire dataset.

#DATA_ROOT=../../data
export PYTHONPATH=${PYTHONPATH}:lib/

python tools/extract_features.py \
    --featcls-output-dir /work1/paupo/playground/hmm/data_2/imgfeat/region_feat_gvd_wo_bgd/feat_cls_1000 \
    --box-output-dir /work1/paupo/playground/hmm/data_2/imgfeat/region_feat_gvd_wo_bgd/raw_bbox \
    --output-file-prefix ph2_hm_detection_vg_100dets_vlp_checkpoint_trainval \
    --max_bboxes 100 --min_bboxes 100 \
    --cfg /work1/paupo/playground/hmm/lib/detectron-vlp/e2e_faster_rcnn_X-101-64x4d-FPN_2x-vlp.yaml \
    --wts /work1/paupo/playground/hmm/lib/detectron-vlp/e2e_faster_rcnn_X-101-64x4d-FPN_2x-vlp.pkl \
    --dataset HM \
    --proc_split "" \
    --image-ext png \
    /work1/paupo/playground/hmm/data_2/img \
    | tee log/log_extract_features_vg_100dets_hm_
