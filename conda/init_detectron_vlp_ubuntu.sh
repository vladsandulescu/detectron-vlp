conda create -n detectron-vlp python=2.7 pip --yes
source ~/anaconda3/etc/profile.d/conda.sh
conda activate detectron-vlp

# For Caffe2 with CUDA 9 and CuDNN 7 support:
conda install pytorch-nightly -c pytorch --yes
pip install Cython
conda install -c anaconda h5py --yes

# To check if Caffe2 build was successful
# python -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure"

# To check if Caffe2 GPU build was successful
# This must print a number > 0 in order to use Detectron
# python -c 'from caffe2.python import workspace; print(workspace.NumCudaDevices())'

# DETECTRON-VLP
cd $HOME/playground/hmm/lib
git clone https://github.com/LuoweiZhou/detectron-vlp.git


# COCOAPI
#Beginning with Matplotlib 3.1, Python 3.6 or above is required, so let's install matplotlib==2.1.0
pip install matplotlib==2.1.0
cd detectron-vlp
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
# Install into global site-packages
make install
# Alternatively, if you do not have permissions or prefer
# not to install the COCO API into global site-packages
python setup.py install --user

# DETECTRON
cd $HOME/playground/hmm/lib/detectron-vlp
git clone https://github.com/facebookresearch/detectron
cd detectron
pip install -r requirements.txt
cd $HOME/playground/hmm/lib/detectron-vlp/detectron && make
python $HOME/playground/hmm/lib/detectron-vlp/detectron/detectron/tests/test_spatial_narrow_as_op.py

cp /home/ubuntu/anaconda3/envs/detectron-vlp/lib/python2.7/site-packages/torch/lib/libcaffe2_detectron_ops_gpu.so /home/ubuntu/playground/hmm/lib/detectron-vlp/lib/

# see https://github.com/LuoweiZhou/detectron-vlp/issues/5
# You also need to add the detectron-vlp/lib folder to PYTHONPATH (Pycharm interpreter settings)

cd $HOME/playground/hmm/lib/detectron-vlp
wget -O e2e_faster_rcnn_X-101-64x4d-FPN_2x-vlp.yaml "https://onedrive.live.com/download?cid=E5364FD183A1F5BB&resid=E5364FD183A1F5BB%212013&authkey=AHIvnE1FcggwiLU"
wget -O e2e_faster_rcnn_X-101-64x4d-FPN_2x-vlp.pkl "https://onedrive.live.com/download?cid=E5364FD183A1F5BB&resid=E5364FD183A1F5BB%212014&authkey=AAHgqN3Y-LXcBvU"

pip install ipykernel
python -m ipykernel install --prefix=/home/ubuntu/anaconda3 --name detectron-vlp --display-name "Python (detectron-vlp)"

cd $HOME
echo "Done"
