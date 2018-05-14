using UnityEngine;
using UnityEditor;
using System.Collections;
using System;

namespace ShaderForge {
	[System.Serializable]
	public class SF_Node_Arithmetic : SF_Node {

		public void PrepareArithmetic(int inputCount = 2, ValueType inputType = ValueType.VTvPending, ValueType outputType = ValueType.VTvPending) {
			base.showColor = true;
			UseLowerReadonlyValues( true );


			if( inputCount == 2 ) {
				connectors = new SF_NodeConnector[]{
				SF_NodeConnector.Create( this, "OUT", "", ConType.cOutput, outputType, false ),
				SF_NodeConnector.Create( this, "A", "A", ConType.cInput, inputType, false ).SetRequired( true ),
				SF_NodeConnector.Create( this, "B", "B", ConType.cInput, inputType, false ).SetRequired( true )};
				base.conGroup = ScriptableObject.CreateInstance<SFNCG_Arithmetic>().Initialize( connectors[0], connectors[1], connectors[2] );
			} else if( inputCount == 1 ){
				connectors = new SF_NodeConnector[]{
				SF_NodeConnector.Create( this, "OUT", "", ConType.cOutput, outputType, false ),
				SF_NodeConnector.Create( this, "IN", "", ConType.cInput, inputType, false ).SetRequired( true )};
				base.conGroup = ScriptableObject.CreateInstance<SFNCG_Arithmetic>().Initialize( connectors[0], connectors[1]);
			}
			
		}

		public override int GetEvaluatedComponentCount() {
			int max = 0;
			foreach(SF_NodeConnector con in connectors){
				if( con.conType == ConType.cOutput || !con.IsConnected()) // Only connected ones, for now
					continue;
				//Debug.Log("GetEvaluatedComponentCount from node " + nodeName + " [" + con.label + "] cc = " + con.GetCompCount());
				max = Mathf.Max( max, con.GetCompCount() );
			}
			return max;
		}

		// NOTE(clark): Probably a bug here.
		public override bool IsUniformOutput() {
			if(InputsConnected()){
				if( connectors.Length > 2) {
					bool uniform = GetInputData( "A" ).uniform && GetInputData( "B" ).uniform;

					if(connectors.Length > 3 && GetInputIsConnected("C"))
						uniform &= GetInputData("C").uniform;
					if(connectors.Length > 4 && GetInputIsConnected("D"))
						uniform &= GetInputData("D").uniform;
					if(connectors.Length > 5 && GetInputIsConnected("E"))
						uniform &= GetInputData("E").uniform;
				
					return uniform;
				}
				return ( GetInputData( "IN" ).uniform );
			}
			return true;
		}

		// New system
		public override void RefreshValue() {
			if( connectors.Length == 3 )
				RefreshValue( 1, 2 );
			else
				RefreshValue( 1, 1 );
		}

	}
}