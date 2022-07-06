
<template class="body">
 <section class="vh-100" style="background-color: #eee;">
  <div class="container h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-lg-12 col-xl-11">
        <div class="card text-black" style="border-radius: 25px;">
          <div class="card-body p-md-5">
            <div class="row justify-content-center">
              <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Register</p>

                <form class="mx-1 mx-md-4" role="form" @submit.prevent="onSubmit">

                  <div class="d-flex flex-row align-items-center mb-4">
                    
                    <div class="form-outline flex-fill mb-0">
                      <input type="text" id="name" placeholder="Your Name" class="form-control" name="name" v-model="name" />
                      
                    </div>
                  </div>
                   <div class="d-flex flex-row align-items-center mb-4">
                    
                    <div class="form-outline flex-fill mb-0">
                    
                    <input class="form-control form-control-lg"  type="file" accept="image/*"  name="imageHash" id="imageHash" />
                <div class="small text-muted mt-2">Upload your image. Max file
                  size 50 MB</div>
                    </div>
                  </div>

                 

                 

                  <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                    <button type="submit" class="btn btn-primary btn-lg">Register</button>
                  </div>

                </form>

              </div>
              <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">

                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-registration/draw1.webp"
                  class="img-fluid" alt="Sample image">

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
	
</template>

<script>
import App from "../index";


export default {
components:{
    
 
  },
   data() {
    return {
      name: null,
      imageHash: null,
    };
  },
   methods: {
    onSubmit() {
      let p = {
          name: this.name,
          imageHash: this.imageHash, 
      };
   console.log(this.name, this.imageHash);
      App.App.registerCandidate(p.name, p.imageHash );
      
      
     
      
    }

    getCandidates: async function getCandidates() {
    const { getCandidates } = this.meta.methods;
   let allCandidates= await getCandidates().call();
   return allCandidates;
  },
  const IPFSUploadHandler = async (): Promise<string> => {
    const resp = await ipfsService.pinFileToIPFS(selectedImage);
    if(!resp.data.IpfsHash) throw Error("no IPFS Hash")
    return `https://gateway.pinata.cloud/ipfs/${resp.data.IpfsHash}`
}

async function registerCandidate() {
    const name = candidateFormData.name; // get the name from formdata
    const ipfsImageHash = await IPFSUploadHandler() // getting the IPFS Image Hash from the Pinata API Service
    
    contract.registerCandidate(name, ipfsImageHash); // call the VoteManager registerCandidate Contract Function
}


function vote(address: string) {
    if (!address) {
        throw Error("no address defined")
    }
    contract.vote(address);
}

async function getAllCandidates() {
    const retrievedCandidates = await contract.fetchCandidates();
    const tempArray = [];
    retrievedCandidates.forEach(candidate => {
        tempArray.push({
            id: candidate.id,
            name: candidate.name,
            totalVote: candidate.totalVote,
            imageHash: candidate.imageHash,
            candidateAddress: candidate.candidateAddress
        })
    })
    setCandidates(tempArray)
}

const handleChange = (event: any) => {
    setCandidateFormData((prevState) => {
        return {
            ...prevState,
            [event.target.name]: event.target.value
        }
      })

    
  },
}
</script>
