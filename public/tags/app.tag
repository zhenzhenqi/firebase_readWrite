<app>
	<h1>Hello { userID }</h1>

	<!-- UI for username / userID setting -->
	<input type="text" ref="userInput" placeholder="Enter username/userID">
	<button type="button" onclick={ setUser }>Set Username/UserID</button>

	<message each={ msg in messages }></message>

	<input type="text" ref="authorInput" placeholder="Enter author">
	<input type="text" ref="msgInput" placeholder="Enter message">
	<button type="button" onclick={ saveMsg }>Save Message</button>

	<!-- <msgbyauth each={user in users}></msgbyauth> -->

	<script>
		var tag = this;

		var messagesRef = rootRef.child('messages');
		var userRef = rootRef.child('messagesByUser');

		this.userID = "anonymous"; // Starts anonymous, set by user interface.
		this.messages = [];
		this.users = [];

		this.setUser = function(){
			this.userID = this.refs.userInput.value;
			console.log("userID", this.userID);
		}

		this.saveMsg = function(){
			var key = messagesRef.push().key;
			console.log(key);

			// Our data object that we will write to the database.
			// We could design this model to have other properties, like author.
			var msg = {
				uid: this.refs.userInput.value,
				id: this.refs.authorInput.value,
				message: this.refs.msgInput.value
			};

			var usermsg = {
				id:this.refs.authorInput.value,
				message: this.refs.msgInput.value
			};

			messagesRef.push(msg);
		}
		// Listen for data changes (READ)
		// See 0-dataRead
		messagesRef.on('value', function(snap){
			let dataAsObj = snap.val();
		
		
			var tempData = [];

			//instead of statically typing out the array value, we now read it in
			//from the firebase data obj using a js for loop structure
			for (key in dataAsObj) {
				tempData.push(dataAsObj[key]);
			}

			//finally, we copy this array back to our tag's property field
			// console.log("myMemes", tag.myMemes);
			tag.messages = tempData;

			//same question, 4th time of encounter. Why do we need to call tag update here?
			tag.update();
		});
</app>
